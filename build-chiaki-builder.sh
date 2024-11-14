#!/bin/bash

TAG_NAME="chiaki-ng-switch-builder:latest"
IMAGE_NAME="docker.io/xlanor/${TAG_NAME}"
docker build -f chiaki-ng-build-container/Dockerfile -t ${IMAGE_NAME} .
