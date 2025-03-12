FROM --platform=linux/arm64 supaeromoon:base

# Mac M1/M2 specific dependencies
RUN apt-get update && apt-get install -y \
    clang \
    lldb \
    && rm -rf /var/lib/apt/lists/*

ENV ARCH=arm64
ENV CC=clang
ENV CXX=clang++