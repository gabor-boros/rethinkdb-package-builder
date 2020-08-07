ARG support_commit
FROM rethinkdb/rdb-alpine-support:${support_commit}
ARG commit

WORKDIR /platform/rethinkdb

RUN git remote add rethinkdb https://github.com/rethinkdb/rethinkdb.git
# TODO DISAPPEND
RUN apk add libexecinfo-dev
RUN git fetch --all && git checkout ${commit}
RUN ./configure --allow-fetch CXX=clang++
