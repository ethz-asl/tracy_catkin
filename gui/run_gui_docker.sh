#!/usr/bin/env bash

xhost + local:docker

if docker info | grep "Runtimes.*nvidia.*" &>/dev/null; then
  docker run --rm -it --net=host \
    -e DISPLAY="${DISPLAY}" \
    -e QT_X11_NO_MITSHM=1 \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    --runtime=nvidia --gpus all \
    -e NVIDIA_VISIBLE_DEVICES=all \
    -e NVIDIA_DRIVER_CAPABILITIES=graphics \
    -v "${HOME}":/home/tracy:rw \
    tracy-gui "$@"
else
  docker run --rm -it --net=host --device /dev/dri \
    -e DISPLAY="${DISPLAY}" \
    -e QT_X11_NO_MITSHM=1 \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    -v "${HOME}":/home/tracy:rw \
    tracy-gui "$@"
fi
