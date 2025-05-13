#!/bin/bash

# Load TS_AUTHKEY from Docker secret
export TS_AUTHKEY=$(cat /run/secrets/TS_AUTHKEY)

# Start Tailscale
tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &
sleep 3

tailscale up --authkey="${TS_AUTHKEY}" \
  --hostname=speedtest-oracle \
  --accept-routes=false \
  --ssh \
  --ephemeral \
  --reset \
  --hostname=speedtest-oracle.narwhal-halibut.ts.net

# Start service
exec /init
