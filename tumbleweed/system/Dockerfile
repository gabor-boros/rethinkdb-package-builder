FROM rethinkdb/rdbcheckout AS priorcheckout

FROM opensuse/tumbleweed

# Starting from openSUSE server edition
RUN zypper -n install patch
RUN zypper -n install libopenssl-devel
RUN zypper -n install make
RUN zypper -n install git-core
RUN zypper -n install zlib-devel libcurl-devel
RUN zypper -n install clang8
RUN zypper -n install gcc

RUN mkdir /platform

# Copy cloned and mostly-fetched rethinkdb directory
COPY --from=priorcheckout /rdb /platform
