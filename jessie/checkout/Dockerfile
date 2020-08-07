ARG support_commit
FROM rethinkdb/rdb-jessie-support:${support_commit}
ARG commit

WORKDIR /platform/rethinkdb

RUN git remote add rethinkdb https://github.com/rethinkdb/rethinkdb.git
RUN git fetch --all && git checkout ${commit}
RUN ./configure --allow-fetch
