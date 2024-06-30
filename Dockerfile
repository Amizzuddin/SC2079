ARG REPOSITORY_NAME
ARG ROOT_DIRECTORY=/root
ARG WORKSPACE=${ROOT_DIRECTORY}/${REPOSITORY_NAME}
ARG DISTRO=humble
############################################### BASE IMAGE ###############################################
FROM ubuntu:22.04 as BASE

SHELL ["/bin/bash", "-c"]

# UPDATE and UPGRADE related
# using RUN cache to speed up and prevent fetch all of your packages from the internet each time
RUN --mount=target=/var/lib/apt/lists,type=cache,id=apt \
    --mount=target=/var/cache/apt,type=cache,id=apt \
    apt-get update

# APT PACKAGES related
RUN --mount=target=/var/lib/apt/lists,type=cache,id=apt \
    --mount=target=/var/cache/apt,type=cache,id=apt \
    apt-get install -y --no-install-recommends \
    wget

# Copy Workspace into the container
# COPY workspace /root/workspace

############################################### PRODUCTION IMAGE ###############################################
FROM BASE as PROD
ARG REPOSITORY_NAME
ARG ROOT_DIRECTORY
ARG WORKSPACE
ARG DISTRO

# Add the build and remove source files

############################################### DEVELOPMENT IMAGE ###############################################
FROM BASE AS DEV
ARG REPOSITORY_NAME
ARG ROOT_DIRECTORY
ARG WORKSPACE
ARG DISTRO

# additional thing needed but should not be in production


# Set this for podman devcontainer mounting source code folder from host
# otherwise there is warning dubious ownership
RUN git config --global --add safe.directory "*"