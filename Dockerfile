FROM haskell:9.0.2-buster AS builder
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /opt/pointfree-io

RUN cabal update

COPY ./pointfree-io.cabal /opt/pointfree-io/pointfree-io.cabal

RUN cabal build --only-dependencies -j4

COPY . /opt/pointfree-io
RUN cabal install --enable-executable-static --install-method=copy --installdir=bin

ENTRYPOINT ["pointfree-io"]

FROM debian:buster-slim

EXPOSE 8080

ENV PORT 8080

WORKDIR /opt/pointfree-io

RUN apt update && apt install libnuma1

COPY --from=builder /opt/pointfree-io/bin/pointfree-io .
COPY ./static /opt/pointfree-io/static

CMD "/opt/pointfree-io/pointfree-io"
