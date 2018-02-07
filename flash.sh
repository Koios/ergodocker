#!/bin/bash -e

function heading() {
  echo
  echo $1
  echo "============================"
}

heading "= Building firmware"
cd firmware_docker
./docker_rm.sh
heading "== Creating container which builds the firmware"
./docker_build.sh
heading "== Building firmware"
./docker_run.sh

cd ..

heading "= Flashing firmware"
cd loader_docker
heading "== Creating container with flashing tool"
./docker_build.sh
heading "== Flashing firmware"
./docker_run.sh
