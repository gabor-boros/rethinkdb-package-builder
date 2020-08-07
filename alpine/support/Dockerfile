FROM rethinkdb/rdb-alpine-system
ARG commit

WORKDIR /platform/rethinkdb

# TODO: DISAPPEND all apk's
RUN apk add git
RUN apk add bash

RUN git checkout ${commit}

RUN apk add binutils
RUN apk add musl-dev
RUN apk add gcc
RUN apk add g++
RUN apk add python
RUN apk add make
RUN apk add perl
RUN apk add linux-headers

# TODO: Consider adding jemalloc-dev, boost-dev, etc, instead of fetching externally.

RUN ./configure --allow-fetch CXX=clang++
RUN make clean

# Builds external packages
RUN make -j7 support
