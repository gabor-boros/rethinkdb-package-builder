ARG commit
FROM rethinkdb/rdb-bionic-checkout:${commit}

WORKDIR /platform/rethinkdb

RUN make dist
