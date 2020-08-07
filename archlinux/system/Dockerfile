FROM rethinkdb/rdbcheckout AS priorcheckout

FROM archlinux:20200306

# General platform dependencies come before any other decision
RUN pacman -Syu --noconfirm clang protobuf boost jemalloc git python2 make

ADD pythonscript /usr/local/bin/python
RUN chmod +x /usr/local/bin/python

RUN mkdir /platform

# Copy cloned and mostly-fetched rethinkdb directory
COPY --from=priorcheckout /rdb /platform

