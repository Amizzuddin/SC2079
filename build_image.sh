#!/bin/bash

# Argument with default value
SCRIPT_ARGUMENT=${1:-"podman"}
IMAGE_NAME=${2:-"developer_container"}
IMAGE_TAG=${3:-"0.0.0"}

echo "$IMAGE_NAME"

if [[ $SCRIPT_ARGUMENT == "podman" ]];
then
    echo "Building Podman image!"
    podman build --network host --format docker \
        --build-arg REPOSITORY_NAME=$IMAGE_NAME \
        -f Dockerfile -t $IMAGE_NAME:$IMAGE_TAG -t $IMAGE_NAME:latest .
elif [[ $SCRIPT_ARGUMENT == "docker" ]];
then
    echo "Building Docker image!"
    docker build --network host \
        --build-arg REPOSITORY_NAME=$IMAGE_NAME \
        -f Dockerfile -t $IMAGE_NAME:$IMAGE_TAG -t $IMAGE_NAME:latest .
else
    echo "UNKNOWN BUILD COMMAND, Exit program!"
    exit 1
fi