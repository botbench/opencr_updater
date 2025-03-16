# OpenCR Control Board Firmware Updater

This Docker container will pull the latest version of the OpenCR updater and flash your OpenCR controller board.

## But why?

I did not want to "pollute" my TurtleBot3 with extra dependencies that were required to run the updater. These mainly consist of libc and co for the armhf architecture. A simple container made this very easy.

## How to build

First, check out the code from the [GitHub](https://github.com/botbench/opencr_updater) repo and build the container with

```shell
git clone https://github.com/botbench/opencr_updater
cd opencr_updater
docker build -t opencr_updater:latest .
```

## How to pull

If you do not want to build the container, you can simply pull it from [DockerHub](https://hub.docker.com/repository/docker/botbench/opencr_updater) with

```shell
docker pull botbench/opencr_updater:latest
```

## How to run

The container defaults to using serial port `/dev/ttyACM0` and assumes you are flashing for a TurtleBot 3 Burger model. To run with these default values, execute the following command line:

```shell
docker run --rm -ti -v /dev/ttyACM0:/dev/ttyACM0 \
    --privileged  opencr_updater:latest
```

The `-v /dev/ttyACM0:/dev/ttyACM0` makes the host's serial port available inside the conrtainer. The `--priviledged` flag allows it to run with the additional priviledges it requires to access the serial port.

You can change this behaviour by passing arguments as follows:

```shell
 docker run --rm -ti -v /dev/ttyFOO:/dev/ttyttyFOO \
    -e PORT=/dev/ttyFOO -e MODEL=pancake \
    --privileged  opencr_updater:latest
 ```

 A succesful run should look like this:

 ```shell
xander@turtle:~/opencr_updater $ docker run --rm -ti \
    -v /dev/ttyACM0:/dev/ttyACM0 
    --privileged opencr_updater:latest
Dockerised OpenCR updater - Xander Soldaat

Updating OpenCR on port /dev/ttyACM0 for model burger
Continue: [yN]: y

----------------------------------------------

Downloading latest firmware: done.
Extracting firmware: done.
aarch64
arm
OpenCR Update Start..
opencr_ld_shell ver 1.0.0
opencr_ld_main
[  ] file name      : burger.opencr
[  ] file size      : 136 KB
[  ] fw_name        : burger
[  ] fw_ver         : V230127R1
[OK] Open port      : /dev/ttyACM0
[  ]
[  ] Board Name     : OpenCR R1.0
[  ] Board Ver      : 0x17020800
[  ] Board Rev      : 0x00000000
[OK] flash_erase    : 1.00s
[OK] flash_write    : 1.34s
[OK] CRC Check      : D92222 D92222 , 0.005000 sec
[OK] Download
[OK] jump_to_fw
```

The board will produce a pleasant little tune when it is done resetting, and presumably nothing when it fails :)
