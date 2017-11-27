FROM alpine:3.6

ARG PACKER_VERSION=1.1.2

RUN apk add --update --no-cache \
    ca-certificates \
    wget \
  && wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
  && unzip packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/bin \
  && rm -f packer_${PACKER_VERSION}_linux_amd64.zip \
  && chmod +x /usr/bin/packer

ENTRYPOINT ["/usr/bin/packer"]
