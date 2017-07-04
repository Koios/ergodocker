FROM debian:stable

RUN apt-get update
RUN apt-get install --no-install-recommends -y \
    build-essential \
    gcc \
    unzip \
    wget \
    zip \
    gcc-avr \
    binutils-avr \
    avr-libc \
    dfu-programmer \
    dfu-util \
    gcc-arm-none-eabi \
    binutils-arm-none-eabi \
    libnewlib-arm-none-eabi \
    git \
    software-properties-common \
    avrdude

RUN useradd --shell /bin/bash docker
USER docker

RUN mkdir /work
WORKDIR /work
COPY . /work

VOLUME /out

CMD ./guest_build.sh
