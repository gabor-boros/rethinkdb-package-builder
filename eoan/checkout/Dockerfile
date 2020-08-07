ARG support_commit
FROM rethinkdb/rdb-eoan-support:${support_commit}
ARG commit

WORKDIR /platform/rethinkdb

RUN git remote add rethinkdb https://github.com/rethinkdb/rethinkdb.git
RUN git fetch --all && git checkout ${commit}
RUN ./configure --allow-fetch CXX=clang++
