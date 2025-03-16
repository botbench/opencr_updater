# Dockerised OpenCR flasher
# Xander Soldaat <xander@botbench.com>

FROM arm64v8/ubuntu:jammy

ENV DEBIAN_FRONTEND=noninteractive \
    PORT=/dev/ttyACM0 \
    MODEL=burger \
    UPDATE_URL=https://github.com/ROBOTIS-GIT/OpenCR-Binaries/raw/master/turtlebot3/ROS2/latest/opencr_update.tar.bz2

# Install dependencies and clean up
RUN dpkg --add-architecture armhf && \
    apt-get update && apt-get install -y \
    libc6:armhf \
    wget \
    bash \
    && rm -rf /var/lib/apt/lists/*
    
WORKDIR /source
COPY do_update.sh .
CMD ["./do_update.sh", "$PORT", "$MODEL.opencr"]

