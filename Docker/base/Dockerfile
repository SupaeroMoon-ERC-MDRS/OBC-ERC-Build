FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
ENV WORKSPACE=/supaeromoon
ENV ROS_DISTRO=humble

WORKDIR /supaeromoon

# Install common dependencies and prerequisites for ROS 2
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    python3 \
    python3-pip \
    wget \
    curl \
    software-properties-common \
    gnupg2 \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Add the ROS 2 repository
RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | \
    tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Install ROS 2 Humble base and essential packages
RUN apt-get update && apt-get install -y \
    ros-${ROS_DISTRO}-ros-base \
    ros-${ROS_DISTRO}-ros-core \
    ros-${ROS_DISTRO}-rosbridge-server \
    python3-colcon-common-extensions \
    python3-rosdep \
    python3-vcstool \
    && rm -rf /var/lib/apt/lists/*

# Install ROS 2 visualization and development tools
RUN apt-get update && apt-get install -y \
    ros-${ROS_DISTRO}-xacro \
    ros-${ROS_DISTRO}-rviz2 \
    ros-${ROS_DISTRO}-rqt* \
    ros-${ROS_DISTRO}-diagnostic-updater \
    ros-${ROS_DISTRO}-launch-testing \
    ros-${ROS_DISTRO}-launch-testing-ros \
    && rm -rf /var/lib/apt/lists/*

# Install ROS 2 navigation and control packages
RUN apt-get update && apt-get install -y \
    ros-${ROS_DISTRO}-nav2-bringup \
    ros-${ROS_DISTRO}-navigation2 \
    ros-${ROS_DISTRO}-slam-toolbox \
    ros-${ROS_DISTRO}-teleop-twist-keyboard \
    ros-${ROS_DISTRO}-tf2-tools \
    ros-${ROS_DISTRO}-tf2-ros \
    ros-${ROS_DISTRO}-joy \
    ros-${ROS_DISTRO}-joy-linux \
    && rm -rf /var/lib/apt/lists/*

# Install ROS 2 simulation packages (Gazebo packages are not available for Humble on Ubuntu 22.04)
RUN apt-get update && apt-get install -y \
    ros-${ROS_DISTRO}-robot-state-publisher \
    ros-${ROS_DISTRO}-joint-state-publisher \
    ros-${ROS_DISTRO}-joint-state-publisher-gui \
    && rm -rf /var/lib/apt/lists/*

# Install development tools and testing dependencies
RUN apt-get update && apt-get install -y \
    python3-pytest \
    python3-pytest-cov \
    python3-flake8 \
    python3-flake8-docstrings \
    ros-dev-tools \
    && rm -rf /var/lib/apt/lists/*

# Initialize rosdep
RUN rosdep init || true && rosdep update

# Source ROS 2 in .bashrc
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> /root/.bashrc

# Clone all repositories from the organization
RUN cd ${WORKSPACE} && \
    curl -s "https://api.github.com/orgs/SupaeroMoon-ERC-MDRS/repos?per_page=100" | \
    jq -r '.[].clone_url' | \
    while read url; do \
        git clone "$url" || echo "Failed to clone $url"; \
    done