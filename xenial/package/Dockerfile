ARG commit
FROM rethinkdb/rdb-xenial-checkout:${commit}

WORKDIR /platform/rethinkdb
# We refetch to get any last-minute tags.
RUN git fetch --all && git clean -fd
RUN make -j7 build-deb UBUNTU_RELEASE=xenial
