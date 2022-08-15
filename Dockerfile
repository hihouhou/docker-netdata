#
# netdata Dockerfile
#
# https://github.com/
#

# Pull base image.
FROM debian:latest

MAINTAINER hihouhou < hihouhou@hihouhou.com >

ENV NETDATA_VERSION v1.36.1

# Install netdata
RUN apt-get update && \
    apt-get install -y zlib1g-dev uuid-dev libuv1-dev libmnl-dev gcc make git autoconf autoconf-archive autogen automake pkg-config curl wget

RUN mkdir -p /opt/netdata && \
    cd /opt/netdata && \
    wget https://api.github.com/repos/netdata/netdata/tarball/${NETDATA_VERSION} -O ${NETDATA_VERSION}.tar.gz && \
    tar xf  ${NETDATA_VERSION}.tar.gz --strip-components=1 && \
    bash netdata-installer.sh --dont-wait

WORKDIR /etc/netdata

EXPOSE 19999

CMD ["/usr/sbin/netdata", "-D"]
