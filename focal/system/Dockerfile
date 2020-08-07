FROM rethinkdb/rdbcheckout AS priorcheckout

FROM ubuntu:focal

# General platform dependencies come before any other decision
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata \
    && ln -fs /usr/share/zoneinfo/UTC /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get update && apt-get install -y \
    git build-essential protobuf-compiler python \
    libprotobuf-dev libcurl4-openssl-dev libboost-all-dev \
    libncurses5-dev wget m4 clang libssl-dev \
    debhelper curl

RUN mkdir /platform

# Copy cloned and mostly-fetched rethinkdb directory
COPY --from=priorcheckout /rdb /platform