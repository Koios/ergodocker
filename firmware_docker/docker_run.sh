#!/bin/bash -e

source docker_common.sh

docker run                   \
  --name=qmk_firmware_built  \
  --volume=out:/out:rw,z     \
  "$docker_img"              \
  ./guest_build.sh "$@"
