#!/bin/bash

export TS_AUTHKEY=$(cat /run/secrets/TS_AUTHKEY)

# Start Tailscale with SOCKS5 proxy
tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &
sleep 3

# DNS proxy to forward DNS queries to MagicDNS
socat UDP-LISTEN:53,fork UDP:100.100.100.100:53 &

# Configure DNS for tailnet hostname resolution
echo "nameserver 127.0.0.1" > /etc/resolv.conf
echo "search narwhal-halibut.ts.net" >> /etc/resolv.conf

# Bring up Tailscale
tailscale up --authkey="${TS_AUTHKEY}" \
  --hostname=uptime-kuma \
  --accept-routes=true \
  --accept-dns=false \
  --ssh \
  --ephemeral \
  --reset

# Start main service
exec node server/server.js
