ARG support_commit
FROM rethinkdb/rdb-centos6-support:${support_commit}
ARG commit

WORKDIR /platform/rethinkdb

RUN git remote add rethinkdb https://github.com/rethinkdb/rethinkdb.git
RUN git fetch --all && git checkout ${commit}
RUN scl enable devtoolset-2 -- ./configure --allow-fetch --fetch curl
