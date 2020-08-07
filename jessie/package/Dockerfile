ARG commit
FROM rethinkdb/rdb-jessie-checkout:${commit}

WORKDIR /platform/rethinkdb
# We refetch to get any last-minute tags.
RUN git fetch --all && git clean -fd
RUN make -j7 build-deb DEB_RELEASE=jessie
