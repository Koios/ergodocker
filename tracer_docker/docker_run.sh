#!/bin/bash -e

source docker_common.sh

# TODO: make parameterizable: mcu, hex file, docker volume
mcu="atmega32u4"

usb_path="/dev/bus/usb"
ergodox_vid='feed'
ergodox_pid='1307'


function throw()
{
  echo "$*" 1>&2
  exit 1
}

function warn()
{
  echo "$*" 1>&2
}


function find_ergodox_usb_devices()
{
  local id=$ergodox_vid':'$ergodox_pid
  local sed_expr='s~^Bus \([0-9]\+\) Device \([0-9]\+\): ID '$id'.*~\1/\2~ip'
  local ret=$(lsusb | sed -n "$sed_expr")
  echo "$ret"
}

function select_device()
{
  local ergodox_devices=( $1 )

  if (( ${#ergodox_devices[@]} == 0 )); then
    throw "No ergodox devices found."
  elif (( ${#ergodox_devices[@]} > 1 )); then
    warn "Multiple ergodox devices found: ${ergodox_devices[@]}"
    warn "Will use the first one."
  fi

  echo "${ergodox_devices[@]}"
}

ergodox_devices=$(find_ergodox_usb_devices)
selected_device=$(select_device "$ergodox_devices")
warn "Selected device: $selected_device"

dev_path="$usb_path/$selected_device"

docker run                                                  \
  --interactive --tty                                       \
  "--device=$dev_path"                                      \
  "--device=/dev/hidraw5"                                      \
  "--device=/dev/hidraw6"                                      \
  "--device=/dev/hidraw7"                                      \
  "--device=/dev/hidraw8"                                      \
  "--device=/dev/hidraw9"                                      \
  "$docker_img"                                             \
  bash # -c "./teensy_loader_cli \"--mcu=$mcu\" -v /in/*.hex"
