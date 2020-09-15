#!/bin/bash

NV_VISIBLE_DEVICES=${1:-"all"}
DOCKER_BRIDGE=${3:-"host"}
ROOT_DIR=`git rev-parse --show-toplevel`

docker run -it --rm \
  --gpus device=$NV_VISIBLE_DEVICES \
  --net=$DOCKER_BRIDGE \
  --shm-size=1g \
  --ulimit memlock=-1 \
  --ulimit stack=67108864 \
  -e LD_LIBRARY_PATH='/workspace/install/lib/' \
  -e PYTHONPATH=$PYTHONPATH:'/workspace/bert/models' \
  -v $PWD:/workspace/bert \
  -v $PWD/results:/results \
  --mount type=bind,source=$ROOT_DIR/external-repositories/smekalka/smekalka/models,target=/workspace/bert/models \
  bert 
