FROM rethinkdb/rdb-docs-system
ARG commit

WORKDIR /platform/docs

RUN git fetch --all && git checkout ${commit}
RUN rake init
# We need to remove --watch from the Rakefile.
# RUN rake build
