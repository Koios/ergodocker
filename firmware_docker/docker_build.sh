#!/bin/bash -ex

source docker_common.sh
docker build -t "$docker_img" .
