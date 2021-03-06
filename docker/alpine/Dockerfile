ARG base_image_version=3.12

FROM alpine:${base_image_version} as runtime

ARG crystal_version=latest

RUN \
  apk add --update --no-cache --force-overwrite \
    # core dependencies
    gc-dev gcc gmp-dev libatomic_ops libevent-static musl-dev pcre-dev \
    # stdlib dependencies
    libxml2-dev openssl-dev openssl-libs-static tzdata yaml-dev zlib-static \
    # dev tools
    make git curl

COPY download_lastest_crystal_package.sh .

RUN /bin/sh download_lastest_crystal_package.sh

RUN rm download_lastest_crystal_package.sh

RUN \
  tar -xz -C /usr --strip-component=1  -f /tmp/crystal.tar.gz \
    --exclude */lib/crystal/lib \
    --exclude */share/crystal/src/llvm/ext/llvm_ext.o \
    --exclude */share/crystal/src/ext/libcrystal.a && \
  rm /tmp/crystal.tar.gz

# Build libcrystal
RUN \
  cd /usr/share/crystal && \
  cc -fPIC -c -o src/ext/sigfault.o src/ext/sigfault.c && \
  ar -rcs src/ext/libcrystal.a src/ext/sigfault.o

CMD ["/bin/sh"]

FROM runtime as build

RUN \
  apk add --update --no-cache --force-overwrite \
    llvm-dev llvm-static g++

CMD ["/bin/sh"]
