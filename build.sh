#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ARCH=$(uname -m)
case "$ARCH" in
    x86_64)
        TARGET_ARCH="amd64"
        ;;
    arm64|aarch64)
        TARGET_ARCH="arm64"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

case "$(uname -s)" in
    Darwin)
        if [ "$TARGET_ARCH" = "arm64" ]; then
            PLATFORM="mac"
        else
            PLATFORM="linux"
        fi
        ;;
    Linux)
        if [ "$TARGET_ARCH" = "arm64" ]; then
            PLATFORM="rasp"
        else
            PLATFORM="linux"
        fi
        ;;
    MINGW*|CYGWIN*|MSYS*)
        PLATFORM="windows"
        ;;
    *)
        echo "Unsupported operating system"
        exit 1
        ;;
esac

echo "Building for platform: $PLATFORM"

docker compose -f "${SCRIPT_DIR}/.devcontainer/docker-compose.yml" build base
docker compose -f "${SCRIPT_DIR}/.devcontainer/docker-compose.yml" build $PLATFORM

echo "Starting container for platform: $PLATFORM using docker compose..."
docker compose -f "${SCRIPT_DIR}/.devcontainer/docker-compose.yml" run --rm $PLATFORM