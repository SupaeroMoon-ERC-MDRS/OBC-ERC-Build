ARG BASE_IMAGE
FROM --platform=linux/arm64 ${BASE_IMAGE}

# Jetson specific dependencies
RUN apt-get update && apt-get install -y \
    nvidia-container-toolkit \
    && rm -rf /var/lib/apt/lists/*

ENV ARCH=arm64
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=all