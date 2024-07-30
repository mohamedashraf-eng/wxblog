FROM ubuntu:22.04

# Avoid stuck at console asking for input
ARG DEBIAN_FRONTEND=noninteractive

# Install compiler and other tools
RUN apt-get update && \
    apt-get install -y \
    make \
    cmake \
    lsb-release \
    git \
    file \
    aptitude \
    gcc-multilib \
    python3 \
    python3-pip \
    wget \
    xz-utils \
    ruby \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install junit2html


# Set the default command
CMD ["/bin/bash"]
