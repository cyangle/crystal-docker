ARG base_image_version=20.04
FROM ubuntu:${base_image_version} as runtime

RUN \
  apt-get update && \
  apt-get install -y apt-transport-https && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
  apt-get install -y tzdata gcc pkg-config libssl-dev libxml2-dev libyaml-dev libgmp-dev git make \
                     libpcre3-dev libevent-dev curl && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY download_lastest_crystal_package.sh .

RUN ["/bin/sh", "download_lastest_crystal_package.sh", "debian"]

RUN rm download_lastest_crystal_package.sh
# nightly packages do not have valid version numbers
RUN dpkg --force-bad-version -i /tmp/crystal.deb

CMD ["/bin/sh"]

FROM runtime as build

RUN \
  apt-get update && \
  apt-get install -y build-essential llvm-10 lld-10 libedit-dev gdb && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/bin/sh"]
