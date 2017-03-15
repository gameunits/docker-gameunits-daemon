# Gameunits source GiT: https://github.com/gameunits/gameunits
# Gameunits daemon Docker GiT: https://github.com/gameunits/docker-gameunits-daemon

# Dockerfile for building and deploying an Gameunits daemon.

FROM ubuntu:latest

MAINTAINER ChenKing <chenking@gmail.com>

RUN apt-get install --yes software-properties-common && \
    add-apt-repository --yes ppa:bitcoin/bitcoin && \
    apt-get update --yes && apt-get install --yes \
       autoconf \
       automake \
       autotools-dev \
       bsdmainutils \
       build-essential \
       git \
       libboost-all-dev \
       libboost-filesystem-dev \
       libboost-program-options-dev \
       libboost-system-dev \
       libboost-test-dev \
       libboost-thread-dev \
       libdb4.8++-dev \
       libdb4.8-dev \
       libevent-dev \
       libminiupnpc-dev \
       libprotobuf-dev \
       libqrencode-dev \
       libqt5core5a \
       libqt5dbus5 \
       libqt5gui5 \
       libqt5webkit5-dev  \
       libsqlite3-dev \
       libssl-dev \
       libtool \
       pkg-config \
       protobuf-compiler \
       qt5-default \
       qtbase5-dev \
       qtdeclarative5-dev \
       qttools5-dev \
       qttools5-dev-tools

RUN git clone https://github.com/gameunits/gameunits /node/gameunitssource

WORKDIR /node/gameunitssource/src

RUN makefile -f makefile.unix USE_UPNP=- && strip gameunitsd && mv gameunitsd /node/gameunitsd && rm -rf /node/gameunitssource

WORKDIR /node
VOLUME ["/node/home"]

ENV HOME /node/home

CMD ["/node/gameunitsd"]

# PORT, RPCPORT
EXPOSE 1337 1338
