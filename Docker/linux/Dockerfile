ARG BASE_IMAGE
FROM --platform=linux/amd64 ${BASE_IMAGE}

# Linux AMD64 specific dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    gdb \
    && rm -rf /var/lib/apt/lists/*

ENV ARCH=amd64
ENV CC=gcc
ENV CXX=g++