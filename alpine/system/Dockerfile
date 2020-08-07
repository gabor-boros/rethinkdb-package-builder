FROM rethinkdb/rdbcheckout AS priorcheckout

FROM alpine:3.11.5

# General platform dependencies come before any other decision
RUN apk update && apk add clang

RUN mkdir /platform

# Copy cloned and mostly-fetched rethinkdb directory
COPY --from=priorcheckout /rdb /platform

