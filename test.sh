#!/bin/bash

# test docker image

cd $(dirname $0)

DOCKERFILE="Dockerfile"

# get dockername
STR=$(cat $DOCKERFILE | grep LABEL | grep dockername) || { echo "failed"; exit 1; }
DOCKERNAME=$(echo "$STR" | cut -d '=' -f 2 | cut -d ' ' -f 3 | sed  's/"//g') || { echo "failed"; exit 1; }

# get dockertag
DOCKERTAG=$(git describe --tags)

set -xe

docker run --rm -it "$@" $DOCKERNAME:$DOCKERTAG
