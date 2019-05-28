FROM debian:stretch-slim

ENV DEBIAN_FRONTEND noninteractive

RUN groupadd -r \
        mongo && \
    useradd -r -g \
        mongo mongo

WORKDIR /opt

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        apt-utils curl ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    curl -s \
        https://downloads.mongodb.org/linux/mongodb-shell-linux-x86_64-debian92-4.0.9.tgz | \
    tar vxz \
        mongodb-linux-x86_64-debian92-4.0.9 && \
    mv \
        mongodb-linux-x86_64-debian92-4.0.9 mongodb-shell && \
    apt-get purge -y --auto-remove \
        apt-utils curl

USER mongo
ENV PATH=/opt/mongodb-shell/bin:$PATH
VOLUME /data
VOLUME /home/mongo/.mongorc.js

ENTRYPOINT ["mongo"]
CMD ["--help"]

