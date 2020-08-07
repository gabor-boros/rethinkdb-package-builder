FROM rethinkdb/rdb-xenial-system
ARG commit

WORKDIR /platform/rethinkdb

RUN git checkout ${commit}
RUN ./configure --allow-fetch
RUN make clean

# Builds external packages
RUN make -j7 support
