#!/bin/bash

#TODO: Scirpt to be the entry point to 
# 1) Clone submodules (if any)
# 2) Build image and tag according to <repository_name>:<version>

get_repository_name(){
    REPOSITORY_NAME=$(basename -s .git `git config --get remote.origin.url`)
    echo $REPOSITORY_NAME # Print the 'return value' to stdout
}

get_latest_version_id(){
    VERSION_FILE=VERSION

    if [ ! -f "$VERSION_FILE" ]; then
        echo "VERSION FILE NOT FOUND!!!!"
        exit
    fi

    local LATEST_VERSION_LOG="UNKNOWN"
    read -r LATEST_VERSION_LOG<$VERSION_FILE
    echo "Latest log from VERSION file: $LATEST_VERSION_LOG" >&2 # Print messager to stderr
    
    VERSION_ID=$(echo $LATEST_VERSION_LOG | cut -d' ' -f1)
    # echo "Version detected: $VERSION_ID" >&2
    echo $VERSION_ID
}

build_image(){
    # To add function with parameters
    # build_image $RESULT # from caller pass function with parameters
    # echo "Building image with name: $1" # from calle function takes in parameter

    IMAGE_NAME=$(get_repository_name)
    TAG_ID=$(get_latest_version_id)

    # IMAGE_NAME_TAG="$IMAGE_NAME:$TAG_ID"
    echo "Building $IMAGE_NAME:$TAG_ID image"

    # TODO: To find a way to tell if its podman or docker!
    # Build docker/podman image
    bash build_image.sh podman $IMAGE_NAME $TAG
}

build_image