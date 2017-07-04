#!/bin/bash -e

source docker_common.sh

# TODO: make parameterizable: mcu, hex file, docker volume
mcu="atmega32u4"

usb_path="/dev/bus/usb"
teensy_vid='16C0'
teensy_pid='0478'


function throw()
{
  echo "$*" 1>&2
  exit 1
}

function warn()
{
  echo "$*" 1>&2
}


function find_teensy_usb_devices()
{
  local id=$teensy_vid':'$teensy_pid
  local sed_expr='s~^Bus \([0-9]\+\) Device \([0-9]\+\): ID '$id'.*~\1/\2~ip'
  local ret=$(lsusb | sed -n "$sed_expr")
  echo "$ret"
}

function select_device()
{
  local teensy_devices=( $1 )

  if (( ${#teensy_devices[@]} == 0 )); then
    throw "No teensy devices found."
  elif (( ${#teensy_devices[@]} > 1 )); then
    warn "Multiple teensy devices found: ${teensy_devices[@]}"
    warn "Will use the first one."
  fi

  echo "${teensy_devices[@]}"
}

teensy_devices=$(find_teensy_usb_devices)
selected_device=$(select_device "$teensy_devices")
warn "Selected device: $selected_device"

dev_path="$usb_path/$selected_device"

docker run                                                  \
  --interactive --tty                                       \
  "--device=$dev_path"                                      \
  --volumes-from=qmk_firmware_built                         \
  --volume=out:/in:ro,z                                     \
  "$docker_img"                                             \
  bash -c "./teensy_loader_cli \"--mcu=$mcu\" -v /in/*.hex"
