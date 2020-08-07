ARG commit
FROM rethinkdb/rdb-focal-checkout:${commit}

WORKDIR /platform/rethinkdb

# Clean "dirty" files, most likely external re2, which changes from
# 2.3.x to 2.4.x.
# We refetch to get any last-minute tags.
RUN git fetch --all && git clean -fd

RUN make -j7 build-deb UBUNTU_RELEASE=focal
