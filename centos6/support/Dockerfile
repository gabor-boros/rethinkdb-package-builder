FROM rethinkdb/rdb-centos6-system
ARG commit

WORKDIR /platform/rethinkdb

RUN git checkout ${commit}
# DISAPPEND: Remove curl-devel package
RUN scl enable devtoolset-2 -- ./configure --allow-fetch --fetch curl
RUN scl enable devtoolset-2 -- make clean

# Builds external packages
RUN scl enable devtoolset-2 -- make -j7 support
