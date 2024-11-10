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
    podman build -f curl-build/Dockerfile.base \
                -t ${IMAGE_NAME} .
else

  # Create output directory if it doesn't exist
  mkdir -p "${OUTPUT_DIR}"

  # Make script executable
  chmod +x "./curl-build/${SCRIPT_NAME}"

  # Run the container
  echo "Starting container with ${SCRIPT_NAME}..."
  podman run \
      --rm \
      -v "$(pwd)/curl-build/${SCRIPT_NAME}:/${SCRIPT_NAME}:Z" \
      -v "$(pwd)/switch/curl/PKGBUILD:/switch/curl/PKGBUILD:Z" \
      -v "$(pwd)/${OUTPUT_DIR}:/output:Z" \
      --user build \
      -e WORKDIR=/output \
      "${IMAGE_NAME}" \
      /bin/sh -c "sudo rm -rf /output/* && sudo chown build:build /switch/curl && cd / && ./${SCRIPT_NAME}"

  echo "curl has been compiled."
fi