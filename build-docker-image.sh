#!/bin/bash

cd "`dirname $(readlink -f ${0})`"

podman build "$@" -t chiaki-switch .
