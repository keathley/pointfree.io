FROM debian:bullseye-20221219-slim
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential=12.9 \
      ca-certificates=20210119 \
      curl=7.74.0-1.3+deb11u3 \
      git=1:2.30.2-1 \
      libffi-dev=3.3-6 \
      libgmp-dev=2:6.2.1+dfsg-1+deb11u1 \
      libncurses-dev=6.2+20201114-2 \
      libnuma-dev=2.0.12-1+b1 \
      zlib1g-dev=1:1.2.11.dfsg-2+deb11u2 && \
    rm -rf /var/lib/apt/lists/*

ARG CABAL_VERSION=3.6.2.0
ARG GHC_VERSION=9.0.2

RUN curl https://downloads.haskell.org/~ghcup/x86_64-linux-ghcup > /usr/bin/ghcup && \
    chmod +x /usr/bin/ghcup && \
    ghcup -v install ghc --isolate /usr/local --force ${GHC_VERSION} && \
    ghcup -v install cabal --isolate /usr/local/bin --force ${CABAL_VERSION} && \
    cabal update 

COPY . .

RUN cabal configure && cabal install

ENTRYPOINT ["cabal", "run"]
