ARG commit
FROM rethinkdb/rdb-centos8-checkout:${commit}

WORKDIR /platform/rethinkdb
# We refetch to get any last-minute tags.
RUN git fetch --all && git clean -fd
RUN ln -s "$PWD"/build/release_clang build/release
RUN CXX=clang++ ./scripts/build-rpm.sh
