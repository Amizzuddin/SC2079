############################################### DEVELOPER IMAGE ###############################################
FROM navikey/raspbian-buster as DEV

ARG REPOSITORY_NAME
ARG ROOT_DIRECTORY=/root
ARG WORKSPACE=${ROOT_DIRECTORY}/${REPOSITORY_NAME}

ENV DEBIAN_FRONTEND noninteractive

SHELL ["/bin/bash", "-c"]

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    netcat \
    git \
    ssh \
    python3-dev \
    python3-pip \
    libatomic1
    # && rm -rf /var/lib/apt/lists/

# Ensure all dependencies are downloaded
COPY requirements.txt $WORKSPACE/requirements.txt

RUN --mount=type=cache,id=pip,target=/root/.cache \
    python3 -m pip install --upgrade -r $WORKSPACE/requirements.txt

# Set this for podman devcontainer mounting source code folder from host
# otherwise there is warning dubious ownership
RUN git config --global --add safe.directory "*"

WORKDIR $WORKSPACE