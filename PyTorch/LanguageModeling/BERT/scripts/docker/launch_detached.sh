#!/bin/bash

VOLUME_ATTACH_DIR=${1:-"$(pwd)"}
NV_VISIBLE_DEVICES=${2:-"all"}
DOCKER_BRIDGE=${3:-"host"}

docker run -it -d \
  --name \
  --gpus device=$NV_VISIBLE_DEVICES \
  --net=$DOCKER_BRIDGE \
  --shm-size=1g \
  --ulimit memlock=-1 \
  --ulimit stack=67108864 \
  -e LD_LIBRARY_PATH='/workspace/install/lib/' \
  -v $PWD:/workspace/bert \
  --mount type=bind,source=$VOLUME_ATTACH_DIR/results,target=/workspace/bert/results \
  --mount type=bind,source=$VOLUME_ATTACH_DIR/data,target=/workspace/bert/data \
  bert 
