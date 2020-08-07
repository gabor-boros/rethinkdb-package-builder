ARG distro
ARG commit
FROM rethinkdb/rdb-${distro}-checkout:${commit}

WORKDIR /platform/rethinkdb

RUN make -j7 DEBUG=1
RUN make -j7
