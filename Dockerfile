FROM arm64v8/ubuntu:18.04

#RUN \
#    [ -z "$(apt-get indextargets)" ]

RUN \
    mkdir -p /run/systemd && echo 'docker' > /run/systemd/container

CMD \
    ["/bin/bash"]

ENV \
    DEBIAN_FRONTEND=noninteractive

RUN \
    apt-get update && apt-get install -y --no-install-recommends \
      apt-utils \
      vim \
      nano \
      ssh \
      git \
      sudo \
      git \
      ca-certificates \
      openssl \
      gpg-agent \
      gpgv2 \
      software-properties-common \
      build-essential make python3.7-dev python3-pip libzmq3-dev python3-zmq \
      openjdk-8-jdk automake zip unzip libtool swig libpng-dev pkg-config \
      libhdf5-dev clang libarchive-dev \
      libssl-dev libswscale-dev \
      libusb-1.0-0 libusb-1.0-0-dev ocl-icd-libopencl1 ocl-icd-opencl-dev \
      opencl-headers checkinstall \
      clang-3.8 libatlas-base-dev libopenblas-base libopenblas-dev gfortran \
      capnproto uuid-dev libsodium-dev valgrind \
      libusb-dev cmake libnewlib-arm-none-eabi libhdf5-serial-dev hdf5-tools smbclient \
      influxdb influxdb-client apt-transport-https adduser dfu-util jq \
      wget && \
      rm -rf /var/lib/apt/lists/*

CMD \
    sh sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && locale-gen

ENV \
    LANG=en_US.UTF-8

ENV \
    LANGUAGE=en_US:en

ENV \
    LC_ALL=en_US.UTF-8

RUN \

    useradd -m -G sudo ubuntu -p QmnAakbCwJ8ME && \

    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \

    sudo sed -i "/^[^#]*PasswordAuthentication[[:space:]]no/c\PasswordAuthentication yes" /etc/ssh/sshd_config

USER ubuntu

RUN \

cd /home/ubuntu && \

git clone -b docker https://github.com/r3dlobst3r/raspberry-pilot && \

mv raspberry-pilot raspilot && \

mv /home/ubuntu/raspilot/start_install_tf.sh /home/ubuntu && \

sh /home/ubuntu/start_install_tf.sh

CMD sudo service cron start && sudo service ssh start && /bin/bash
