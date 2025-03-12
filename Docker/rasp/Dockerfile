ARG BASE_IMAGE
FROM --platform=linux/arm64 ${BASE_IMAGE}

# Raspberry Pi specific dependencies
RUN apt-get update && apt-get install -y \
    raspberrypi-kernel-headers \
    && rm -rf /var/lib/apt/lists/*

ENV ARCH=arm64