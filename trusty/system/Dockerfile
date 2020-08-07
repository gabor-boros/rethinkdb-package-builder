FROM rethinkdb/rdbcheckout AS priorcheckout

FROM ubuntu:trusty

# General platform dependencies come before any other decision
RUN apt-get update && apt-get install -y \
    git build-essential protobuf-compiler python \
    libprotobuf-dev libcurl4-openssl-dev libboost-all-dev \
    libncurses5-dev libjemalloc-dev wget m4 g++ libssl-dev \
    debhelper curl

# Untested is the libssl-dev dependency, which is conspicuously absent
# from http://samuelhughes.com/rethinkdb/build_instructions.html

RUN mkdir /platform

# Copy cloned and mostly-fetched rethinkdb directory
COPY --from=priorcheckout /rdb /platform
