#!/bin/bash

cd "`dirname $(readlink -f ${0})`"

docker build "$@" -f Dockerfile.base -t chiaki-ng-switch .
