#!/bin/bash

source docker_common.sh

docker build "--tag=$docker_img" .
