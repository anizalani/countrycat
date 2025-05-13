#!/bin/bash

# Load TS_AUTHKEY from Docker secret
export TS_AUTHKEY=$(cat /run/secrets/TS_AUTHKEY)

# Start Tailscale
tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &
sleep 3

tailscale up --authkey="${TS_AUTHKEY}" \
  --hostname=loki \
  --accept-routes=false \
  --ssh \
  --ephemeral \
  --reset \
  --hostname=loki.narwhal-halibut.ts.net

# Start service
exec /usr/bin/loki -config.file=/etc/loki/local-config.yaml
