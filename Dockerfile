FROM ubuntu:latest
RUN apt update -y && \
    apt full-upgrade -y && \
    apt install -y \
    sudo make git gcc g++ ack autoconf automake autopoint binutils bison \
    libncurses5-dev libncursesw5-dev build-essential bzip2 ccache cmake cpio \
    unzip bzip2 wget python3 file rsync gawk xz-utils curl device-tree-compiler \
    fastjar flex gettext gperf haveged help2man intltool libelf-dev libssl-dev \
    libtool lrzsz mkisofs nano ninja-build p7zip patch pkgconf wget vim xxd \
    golang

RUN useradd -m builder && \
    echo 'builder ALL=NOPASSWD: ALL' > /etc/sudoers.d/builder

USER builder
WORKDIR /home/builder

RUN git clone -b master --depth 1 https://github.com/openwrt/openwrt && \
    cd openwrt && \
    ./scripts/feeds update -a && \
    ./scripts/feeds install -a

WORKDIR /home/builder/openwrt
