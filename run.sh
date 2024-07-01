#!/bin/bash

SCRIPT_NAME=$0
COMMAND_TYPE=$1
COMMAND=${COMMAND_TYPE^^} # Convert to uppercase
IMAGE_TYPE=${2:-"dev"}
TARGET=${IMAGE_TYPE^^} # Convert to uppercase
REGISTRY="docker.io/amizzuddin"

# Color code for echo text display
ORANGE='\033[38;5;214m'
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NO_COLOR='\033[0m'

get_repository_name(){
    REPOSITORY_NAME=$(basename -s .git `git config --get remote.origin.url`)
    echo $REPOSITORY_NAME # Print the 'return value' to stdout
}

REPO_NAME=$(get_repository_name)
DEVELOPER_IMAGE_NAME="${REPO_NAME}_dev"
PRODUCTION_IMAGE_NAME=$REPO_NAME


test_command(){
    echo "TEST $TARGET_IMAGE_NAME image"
    if [ -z "$(docker images -q $TARGET_IMAGE_NAME:latest 2> /dev/null)" ];
    then
        echo "Image $TARGET_IMAGE_NAME not found"
        pull_command
    fi

    TEST_IMAGE_NAME=${TARGET_IMAGE_NAME}_test

    # echo "docker run --rm --detach --network host --name ${TARGET_IMAGE_NAME}_test $TARGET_IMAGE_NAME:latest"
    if [[ "$TARGET" == "DEV" ]];
    then
        # UnitTest
        docker run --rm --network host -v $PWD:/root/$REPO_NAME/ --name $TEST_IMAGE_NAME $TARGET_IMAGE_NAME:latest \
            /bin/bash -c "coverage run -m pytest Workspace/Tests/UnitTest -vs && coverage report --show-missing --format=markdown > unit_test_coverage.md"
    else
        # docker run --detach --network host -v $PWD:/root/$REPO_NAME/ --name $TEST_IMAGE_NAME $TARGET_IMAGE_NAME:latest
        # UnitTest
        # docker run --rm --network host -v $PWD:/root/$REPO_NAME/ --name $TEST_IMAGE_NAME $TARGET_IMAGE_NAME:latest \
            #     /bin/bash -c "coverage run -m pytest Workspace/Tests/IntegrationTest -vs && coverage report --show-missing --format=markdown > integration_test_coverage.md"
        docker run --rm -p 5000:5000 --name $TEST_IMAGE_NAME $TARGET_IMAGE_NAME:latest
    fi
}

pull_command(){
    echo "PULL $TARGET_IMAGE_NAME image from '$REGISTRY'"
    docker pull $REGISTRY/$TARGET_IMAGE_NAME:latest
    echo "TAG $REGISTRY/$TARGET_IMAGE_NAME:latest to $TARGET_IMAGE_NAME:latest"
    docker tag $REGISTRY/$TARGET_IMAGE_NAME:latest $TARGET_IMAGE_NAME:latest
}

push_command(){
    echo "PUSH $TARGET_IMAGE_NAME image to '$REGISTRY'"
    docker push $REGISTRY/$TARGET_IMAGE_NAME:latest
}

get_build_args(){
    BUILD_ARGS="--build-arg REPOSITORY_NAME=$REPO_NAME -f Dockerfile -t $REGISTRY/$TARGET_IMAGE_NAME:latest -t $TARGET_IMAGE_NAME:latest --target $TARGET ."
    echo $BUILD_ARGS # Print the 'return value' to stdout
}

build_command(){
    echo "BUILD $TARGET_IMAGE_NAME image!"

    BUILD_ARGS=$(get_build_args)
    docker build --network host $BUILD_ARGS
}

get_target_image_name() {
    TARGET_IMAGE_NAME=${PRODUCTION_IMAGE_NAME}
    if [[ "$TARGET" == "DEV" ]];
    then
        TARGET_IMAGE_NAME=${DEVELOPER_IMAGE_NAME}
    fi
}

check_commands(){
    if [ -z ${COMMAND} ]; then
        print_help $SCRIPT_NAME
    fi
    get_target_image_name
    case $COMMAND in
        PULL)
            pull_command
            ;;
        PUSH)
            push_command
            ;;
        BUILD)
            build_command
            ;;
        TEST)
            test_command
            ;;
        *)
            print_help $SCRIPT_NAME
            ;;
    esac
}

print_help() {
    echo -e ""
    echo -e "Usage:"
    echo -e "  ${GREEN}bash $1 [command] [target]${NO_COLOR}"
    echo -e ""
    echo "Available commands:"
    echo -e "  ${GREEN}build${NO_COLOR}    BUILD container image"
    echo -e "  ${GREEN}pull${NO_COLOR}     PULL from registry ($REGISTRY)"
    echo -e "  ${GREEN}push${NO_COLOR}     PUSH to registry ($REGISTRY)"
    echo -e "  ${GREEN}test${NO_COLOR}     TEST container image"
    echo "Available targets:"
    echo -e "  ${GREEN}dev${NO_COLOR}      Devcontainer image (${DEVELOPER_IMAGE_NAME})"
    echo -e "  ${GREEN}prod${NO_COLOR}     Production image (${PRODUCTION_IMAGE_NAME})"
    exit
}

check_argument() {
    if [ -z ${TARGET} ]; then
        print_help $SCRIPT_NAME
    fi
    if [[ ! ${TARGET} =~ ^(DEV|PROD)$ ]]; then
        print_help $SCRIPT_NAME
    fi
    check_commands
}

check_argument
