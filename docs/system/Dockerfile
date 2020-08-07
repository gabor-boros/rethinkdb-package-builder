FROM rethinkdb/rdb-docs-docscheckout AS priorcheckout

FROM rethinkdb/rdb-bionic-system

RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get update && apt-get install -y \
    ruby rake bundler

COPY --from=priorcheckout /rdb/docs /platform/docs

WORKDIR /platform/docs

# Now run rake init once, to do a bunch of fetching and installing of
# dependencies.  e4be287c2 is a Dec 28 2019 commit in master.

RUN git fetch --all && git checkout e4be287c2
RUN rake init
