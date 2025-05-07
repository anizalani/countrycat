FROM grafana/grafana:latest

USER root

# Install dependencies
RUN apk add --no-cache curl bash ip6tables iptables su-exec

# Dynamically detect architecture and install matching Tailscale version
ARG TS_VER=1.66.4
RUN ARCH=$(uname -m) && \
    case "$ARCH" in \
      x86_64)   TS_ARCH="amd64" ;; \
      aarch64)  TS_ARCH="arm64" ;; \
      armv7l)   TS_ARCH="arm" ;; \
      *)        echo "Unsupported arch: $ARCH" && exit 1 ;; \
    esac && \
    curl -fsSL "https://pkgs.tailscale.com/stable/tailscale_${TS_VER}_${TS_ARCH}.tgz" | \
    tar -xz -C /usr/local/bin --strip-components=1 \
      "tailscale_${TS_VER}_${TS_ARCH}/tailscaled" \
      "tailscale_${TS_VER}_${TS_ARCH}/tailscale" && \
    mkdir -p /var/run/tailscale /var/cache/tailscale /var/lib/tailscale

# Create a directory for the state file - this should be mounted as a volume from the host
RUN mkdir -p /var/lib/tailscale && \
    chown -R grafana:root /var/lib/tailscale

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Make sure we expose Grafana's port
EXPOSE 3000

ENTRYPOINT ["/entrypoint.sh"]
