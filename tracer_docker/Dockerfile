FROM debian:stable

# separating the update from the install allows the update step to be cached
# by Docker, independently of what we want to actuall install
RUN apt-get update
RUN apt-get install -y --no-install-recommends \
  build-essential \
  gcc \
  libusb-dev

RUN useradd --shell /bin/bash docker
USER docker
WORKDIR /work

COPY ./hid_listen/* ./
RUN make
