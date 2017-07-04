FROM debian:stable

RUN apt-get update
RUN apt-get install --no-install-recommends -y \
    build-essential \
    gcc-avr \
    binutils-avr \
    avr-libc

RUN useradd --shell /bin/bash docker
USER docker

RUN mkdir /work
WORKDIR /work
COPY . /work

VOLUME /out

CMD ./guest_build.sh
