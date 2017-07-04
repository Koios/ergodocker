FROM debian:stable

# separating the update from the install allows the update step to be cached
# by Docker, independently of what we want to actuall install
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
  build-essential \
  gcc \
  libusb-dev

RUN echo "root:Docker!" | chpasswd

RUN useradd --shell /bin/bash docker
USER docker
WORKDIR /work

COPY ./teensy_loader_cli/teensy_loader_cli.c ./
RUN gcc -std=c11 -Wall -Wextra -pedantic -DUSE_LIBUSB \
  -o teensy_loader_cli \
  teensy_loader_cli.c \
  -lusb