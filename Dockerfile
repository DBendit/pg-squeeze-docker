ARG PSQL_VERSION=16
FROM postgres:${PSQL_VERSION}
LABEL MAINTAINER Dave Bendit <david@ibendit.com>

ARG PSQL_VERSION
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    ca-certificates \
    git \
    postgresql-server-dev-${PSQL_VERSION} && \
    mkdir /build && \
    cd /build && \
    git clone https://github.com/cybertec-postgresql/pg_squeeze.git && \
    cd pg_squeeze && \
    make && \
    make install && \
    cd .. && \
    rm -rf build && \
    apt-get remove -y build-essential ca-certificates git && \
    apt-get autoremove --purge -y && \
    apt-get clean && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/*

