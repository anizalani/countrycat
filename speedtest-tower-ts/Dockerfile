FROM lscr.io/linuxserver/speedtest-tracker:latest

USER root

RUN apk add --no-cache curl bash ip6tables iptables su-exec

ARG TS_VER=1.66.4
RUN ARCH=$(uname -m) && \
    case "$ARCH" in \
      x86_64) TS_ARCH="amd64" ;; \
      aarch64) TS_ARCH="arm64" ;; \
      armv7l) TS_ARCH="arm" ;; \
      *) echo "Unsupported arch: $ARCH" && exit 1 ;; \
    esac && \
    curl -fsSL "https://pkgs.tailscale.com/stable/tailscale_${TS_VER}_${TS_ARCH}.tgz" | \
    tar -xz -C /usr/local/bin --strip-components=1

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
