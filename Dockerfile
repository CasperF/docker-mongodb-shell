FROM debian:stretch-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        apt-utils && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl && \
    apt-get clean

RUN ["update-ca-certificates", "--verbose", "--fresh"]

WORKDIR /opt

RUN curl -s \
        https://downloads.mongodb.org/linux/mongodb-shell-linux-x86_64-debian92-4.0.9.tgz | \
    tar vxz \
        mongodb-linux-x86_64-debian92-4.0.9 && \
    mv \
        mongodb-linux-x86_64-debian92-4.0.9 mongodb-shell

ENV PATH=/opt/mongodb-shell/bin:$PATH

# Keeping ca-certificates necessary for mongodb-shell
RUN apt-get remove -y \
        apt-utils curl && \
    apt-get -y autoremove

ENTRYPOINT ["mongo"]
CMD ["--help"]

