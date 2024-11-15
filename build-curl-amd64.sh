#! /bin/bash
TAG_NAME="compile-switchcurl-base:latest"
IMAGE_NAME="docker.io/xlanor/${TAG_NAME}"
SCRIPT_NAME="compile_curl.sh"
OUTPUT_DIR="./output"

BASE=0
while getopts "b" opt; do
  case "$opt" in
    b) BASE=1
      ;;
  esac
done

shift $((OPTIND-1))
[ "${1:-}" = "--" ] && shift


if [[ "$BASE" -eq 1 ]]; then
    docker build --no-cache -f curl-build/Dockerfile.base \
                -t ${IMAGE_NAME} .
else

  # Cleanup mbedtls artifacts 
  rm -rf ./switch/mbedtls/pkg
  rm -rf ./switch/mbedtls/src
  rm -f ./switch/mbedtls/*.bz2
  # Create output directory if it doesn't exist
  mkdir -p "${OUTPUT_DIR}"

  # Make script executable
  chmod +x "./curl-build/${SCRIPT_NAME}"

  # Run the container
  echo "Starting container with ${SCRIPT_NAME}..."
  docker run \
      --rm \
      -v "$(pwd)/curl-build/${SCRIPT_NAME}:/${SCRIPT_NAME}:Z" \
      -v "$(pwd)/switch/curl/PKGBUILD:/switch/curl/PKGBUILD:Z" \
      -v "$(pwd)/${OUTPUT_DIR}:/output:Z" \
      -v "$(pwd)/switch/mbedtls:/switch/mbedtls:Z" \
      --user build \
      -e WORKDIR=/output \
      "${IMAGE_NAME}" \
      /bin/sh -c "sudo rm -rf /output/* && sudo chown -R build:build /switch && cd / && ./${SCRIPT_NAME}"
  
  echo "curl has been compiled."
fi