ARG base_image_version=20.04

FROM ubuntu:${base_image_version} as runtime

ARG crystal_version=latest

RUN \
  apt-get update && \
  apt-get install -y apt-transport-https && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
  apt-get install -y tzdata gcc pkg-config libssl-dev libxml2-dev libyaml-dev libgmp-dev git make \
                     libpcre3-dev libevent-dev libz-dev curl && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY download_lastest_crystal_package.sh .

RUN ./download_lastest_crystal_package.sh debian \
  && dpkg --force-bad-version -i /tmp/crystal.deb \
  && rm /tmp/crystal.deb \
  && rm download_lastest_crystal_package.sh

CMD ["/bin/sh"]

FROM runtime as build

RUN \
  apt-get update && \
  apt-get install -y build-essential llvm-11 lld-11 lldb-11 libedit-dev gdb && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN ln -sf /usr/bin/ld.lld-11 /usr/bin/ld.lld

CMD ["/bin/sh"]
