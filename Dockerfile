### Release image
FROM ubuntu:latest@sha256:adf73ca014822ad8237623d388cedf4d5346aa72c270c5acc01431cc93e18e2d

LABEL org.opencontainers.image.source="https://github.com/patrickhoefler/dockerfilegraph"

RUN \
  # Note that the lack of a "lock" mechanism for apt dependencies
  # currently prevents a fully reproducible build
  apt-get update \
  && apt-get install -y --no-install-recommends \
  # Install Graphviz
  graphviz \
  && rm -rf /var/lib/apt/lists/* \
  \
  # Add a non-root user
  && useradd app

# Run as non-root user
USER app

# This currently only works with goreleaser
# or if you manually copy the binary into the main project directory
COPY dockerfilegraph /

ENTRYPOINT ["/dockerfilegraph"]
