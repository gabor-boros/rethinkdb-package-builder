FROM ubuntu:bionic
RUN mkdir /rdb
WORKDIR /rdb

RUN apt-get update && apt-get install -y \
    git make clang wget

RUN git clone https://github.com/rethinkdb/rethinkdb
WORKDIR /rdb/rethinkdb

# This is also the v24_base_commit of setup.rb
RUN git checkout b2365bef6
RUN ./configure --fetch all CXX=clang++
RUN make -j3 fetch-protobuf fetch-node fetch-boost fetch-v8 fetch-zlib \
    fetch-re2 fetch-openssl fetch-libidn fetch-curl fetch-jemalloc
RUN make clean && rm config.mk
