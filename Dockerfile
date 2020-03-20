ARG BASE_IMAGE=debian
ARG BASE_IMAGE_VERSION=buster-20200224-slim

FROM $BASE_IMAGE:$BASE_IMAGE_VERSION

ARG UID=1000
ARG GID=1000

RUN groupadd \
        -g $GID mongo && \
    useradd -m \
        -u $UID -g $GID mongo

ARG DEBIAN_FRONTEND noninteractive

RUN apt-get update \
&&  apt-get install -y --no-install-recommends \
        curl \
        dumb-init \
        ca-certificates \
&&  apt-get -y clean \
&&  rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
&&  mkdir -p \
        /opt/mongo-shell \
  ; curl -sSL \
      http://downloads.mongodb.org/linux/mongodb-linux-x86_64-debian10-4.2.3.tgz \
  | tar -zx -C /opt/mongo-shell --strip-components=1 \
&&  apt-get purge -y \
        curl

USER mongo
ENV PATH="$PATH:/opt/mongodb-shell/bin"

VOLUME /data

ENTRYPOINT ["/usr/bin/dumb-init", "--", "mongo"]
CMD ["--help"]
