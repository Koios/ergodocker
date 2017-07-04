#!/bin/bash -e

cd firmware_docker
./docker_rm.sh
./docker_build.sh
./docker_run.sh

cd ..

cd loader_docker
./docker_build.sh
./docker_run.sh
