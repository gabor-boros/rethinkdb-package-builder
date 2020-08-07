FROM rethinkdb/rdbcheckout AS priorcheckout

FROM centos:centos8

# General platform dependencies
RUN yum install -y openssl-devel libcurl-devel wget tar m4 \
    git-core gcc-c++ which make python2 boost-devel \
    bzip2 patch clang \
    perl rubygems ruby-devel rpm-build
RUN gem install fpm

RUN alternatives --set python /usr/bin/python2

RUN mkdir /platform

# Copy cloned and mostly-fetched rethinkdb directory
COPY --from=priorcheckout /rdb /platform
