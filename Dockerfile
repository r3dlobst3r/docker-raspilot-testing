FROM arm64v8/ubuntu:18.04

#RUN \
#    [ -z "$(apt-get indextargets)" ]

ENV \
    DEBIAN_FRONTEND=noninteractive

CMD \
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
      gpgv2
      
RUN \
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
