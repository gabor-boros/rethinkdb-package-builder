FROM rethinkdb/rdbcheckout AS priorcheckout

FROM debian:stretch-slim

# General platform dependencies come before any other decision
RUN apt-get update && apt-get install -y \
    git build-essential protobuf-compiler python \
    libprotobuf-dev libcurl4-openssl-dev libboost-all-dev \
    libncurses5-dev wget m4 clang libssl1.0-dev \
    debhelper curl

RUN mkdir /platform

# Copy cloned and mostly-fetched rethinkdb directory
COPY --from=priorcheckout /rdb /platform
