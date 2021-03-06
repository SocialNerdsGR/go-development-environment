FROM golang:1.16-buster

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils 2>&1 \
    && useradd -s /bin/bash -m serveruser

# Verify git, process tools, lsb-release (common in install instructions for CLIs) installed.
RUN apt-get -y install git iproute2 procps lsb-release

# Install Go tools.
RUN go get -v \
        github.com/mdempsky/gocode \
        github.com/ramya-rao-a/go-outline \
        github.com/acroca/go-symbols \
        golang.org/x/tools/cmd/guru \
        golang.org/x/tools/cmd/gorename \
        github.com/go-delve/delve/cmd/dlv \
        github.com/rogpeppe/godef \
        golang.org/x/tools/cmd/goimports \
        golang.org/x/lint/golint 2>&1 \
        github.com/sqs/goreturns \
        github.com/uudashr/gopkgs/v2/cmd/gopkgs \
    && go get -v \
        golang.org/x/tools/gopls \
    # Clean up.
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

RUN chown -R serveruser:serveruser /go

USER serveruser

# Revert workaround at top layer.
ENV DEBIAN_FRONTEND=dialog

# Expose service ports.
EXPOSE 8000
