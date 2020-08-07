ARG commit
FROM rethinkdb/rdb-trusty-checkout:${commit}

WORKDIR /platform/rethinkdb
# We refetch to get any last-minute tags.
RUN git fetch --all && git clean -fd

# As a hack, we edit the mk/packaging.mk script to not talk about
# g++-5.  Because it is wrong.  trusty doesn't have g++-5, its g++ is
# 4.8.  That should only be for xenial.
#
# We also hack gen-version.sh to not construct a dirty version number.

RUN perl -pi -e 's/g\+\+-5/g\+\+/' mk/packaging.mk
RUN perl -pi -e 's/version-dirty"/version"/' scripts/gen-version.sh

RUN make -j7 build-deb UBUNTU_RELEASE=trusty
