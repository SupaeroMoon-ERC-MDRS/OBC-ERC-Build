# Docker Container Setup for OBC-ERC Project

This project uses Docker containers with ROS 2 Humble for development and deployment across multiple platforms. The container system is designed to work on various architectures including x86_64 (AMD64), ARM64 (Raspberry Pi 5, NVIDIA Jetson, Apple Silicon), and supports Linux, macOS, and Windows environments.

## Prerequisites

### Required
- **Docker** installed on your system ([Install Docker](https://docs.docker.com/get-docker/))

### Optional (for Visual Studio Code Development)
If you prefer using VS Code for development:
- Install **Visual Studio Code** ([Download VS Code](https://code.visualstudio.com/))
- Install the **Dev Containers** extension:
  1. Open VS Code
  2. Go to Extensions (`Ctrl+Shift+X` or `Cmd+Shift+X` on macOS)
  3. Search for and install `Dev Containers` by Microsoft

## Architecture

The project uses a multi-stage Docker build approach:
- `base/Dockerfile`: Common ROS 2 Humble setup and dependencies
- Platform-specific Dockerfiles:
  - `linux/`: For x86_64 Linux systems
  - `mac/`: For Apple Silicon (M1/M2) Macs
  - `rasp/`: For Raspberry Pi 5
  - `jetson/`: For NVIDIA Jetson
  - `windows/`: For Windows systems

## Quick Start

### 1. Clone the Repository

```zsh
git clone https://github.com/SupaeroMoon-ERC-MDRS/OBC-ERC-Build.git
cd OBC-ERC-Build
```

### 2. Build and Run

The `build.sh` script automatically detects your platform and builds the appropriate container:

```zsh
./build.sh
```

This script will:
1. Detect your system architecture (AMD64/ARM64)
2. Identify your platform (Linux/Mac/Windows/Raspberry Pi/Jetson)
3. Build the base image with common ROS 2 dependencies
4. Build the platform-specific image
5. Start a container with the correct configuration

### 3. Development Environment

#### Option 1: Direct Terminal Access
After running `build.sh`, you'll have direct terminal access to the container with ROS 2 Humble and all dependencies installed.

#### Option 2: VS Code Integration
1. Open VS Code
2. Click the green `><` button in the bottom-left corner
3. Select "Reopen in Container"
4. VS Code will reopen with full development environment inside the container

### Workspace Structure

The container mounts a shared volume at `/supaeromoon`

### Platform-Specific Details

- **Linux AMD64**: Standard ROS 2 development environment
- **Apple Silicon**: Optimized for M1/M2 with ARM64 support
- **Raspberry Pi**: Custom configuration for RPi 5
- **Jetson**: NVIDIA-specific optimizations and CUDA support
- **Windows**: WSL2 compatibility layer

### Advanced Usage

You can build specific platform images manually:

```zsh
# Build base image
docker compose build base

# Build platform-specific image
docker compose build [linux|mac|rasp|jetson|windows]

# Run the container
docker compose run --rm [platform]
```

For development, using `build.sh` is recommended as it handles all platform detection and configuration automatically.
