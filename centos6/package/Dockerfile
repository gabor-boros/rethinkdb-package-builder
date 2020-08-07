ARG commit
FROM rethinkdb/rdb-centos6-checkout:${commit}

WORKDIR /platform/rethinkdb

# We refetch to get any last-minute tags.
RUN git fetch --all && git clean -fd
RUN scl enable devtoolset-2 rh-ruby24 -- ./scripts/build-rpm.sh
