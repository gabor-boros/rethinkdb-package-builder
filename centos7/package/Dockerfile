ARG commit
FROM rethinkdb/rdb-centos7-checkout:${commit}

WORKDIR /platform/rethinkdb

# DISAPPEND: Put this in centos7/system.
RUN yum install -y libquadmath-devel

# We refetch to get any last-minute tags.
RUN git fetch --all && git clean -fd
RUN ./scripts/build-rpm.sh
