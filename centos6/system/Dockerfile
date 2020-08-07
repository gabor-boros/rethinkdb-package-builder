FROM rethinkdb/rdbcheckout AS priorcheckout

FROM centos:centos6

# General platform dependencies
RUN yum install -y \
    git-core gcc-c++ npm \
    make ncurses-static zlib-devel zlib-static \
    protobuf-static bzip2 patch perl rpm-build \
    libquadmath-devel centos-release-scl yum-utils wget
RUN rpm --import https://linuxsoft.cern.ch/cern/centos/7/os/x86_64/RPM-GPG-KEY-cern
RUN wget -O /etc/yum.repos.d/slc6-devtoolset.repo http://linuxsoft.cern.ch/cern/devtoolset/slc6-devtoolset.repo

RUN yum install -y devtoolset-2 ncurses-devel boost-static openssl-devel \
    libcurl-devel tar which m4 protobuf-devel jemalloc-devel

RUN yum-config-manager --enable rhel-server-rhscl-6-rpms
RUN yum install -y rh-ruby24 rh-ruby24-ruby-devel
RUN scl enable rh-ruby24 -- gem install fpm

RUN mkdir /platform

# Copy cloned and mostly-fetched rethinkdb directory
COPY --from=priorcheckout /rdb /platform
