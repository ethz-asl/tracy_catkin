#!/usr/bin/env bash

TRACY_VERSION=$(head -n 1 "$(dirname "$0")"/../TRACY_VERSION)
docker build "$(dirname "$0")" -t tracy-gui --build-arg TRACY_VERSION="$TRACY_VERSION"
