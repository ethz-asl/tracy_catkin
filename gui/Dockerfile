FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -q -y --no-install-recommends \
        build-essential cmake \
        ca-certificates git \
        libdbus-1-dev libtbb-dev libegl-dev libfreetype-dev libglfw3-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR opt

RUN git clone --depth=1 https://github.com/capstone-engine/capstone.git -b 4.0.2  && \
    mkdir -p capstone/build && cd capstone/build && \
    cmake .. && make install
ENV LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:/usr/local/lib"

RUN git clone --depth=1 https://github.com/wolfpld/tracy.git -b v0.9.1 && \
    cd tracy/profiler/build/unix && \
    export TRACY_NO_FILESELECTOR=1 && \
    make -j`nproc` LEGACY=1

RUN adduser tracy
USER tracy
WORKDIR /home/tracy
RUN ln -s /opt/tracy/profiler/build/unix/Tracy-release profiler
ENTRYPOINT ./profiler
