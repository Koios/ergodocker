#!/bin/bash -e

# TODO: don't use positional args
export keyboard=${1:-ergodox}
export subproject=${2:-ez}
export keymap=${3:-koios}

cd qmk_firmware
make
cp *.hex /out/
