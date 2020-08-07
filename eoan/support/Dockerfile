FROM rethinkdb/rdb-eoan-system
ARG commit

WORKDIR /platform/rethinkdb

RUN git checkout ${commit}
RUN ./configure --allow-fetch CXX=clang++
RUN make clean

# Builds external packages
RUN make -j7 support
