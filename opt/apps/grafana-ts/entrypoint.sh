#!/bin/bash
set -e

# Create required directories
mkdir -p /var/run/tailscale /var/cache/tailscale /var/lib/tailscale

# Print debug info
echo "Starting Tailscale daemon..."

# Run tailscaled in the background with debug logging
tailscaled --tun=userspace-networking --state=/var/lib/tailscale/tailscaled.state --socket=/var/run/tailscale/tailscaled.sock &
TAILSCALED_PID=$!

# Wait for the daemon to start
echo "Waiting for tailscaled to start..."
sleep 3

# Check if TS_AUTHKEY exists as a file
if [ -f "/run/secrets/TS_AUTHKEY" ]; then
    AUTHKEY=$(cat /run/secrets/TS_AUTHKEY)
    echo "Found auth key from secrets file"
elif [ -n "$TS_AUTHKEY" ]; then
    AUTHKEY=$TS_AUTHKEY
    echo "Using auth key from environment variable"
else
    echo "ERROR: No Tailscale auth key provided. Please set TS_AUTHKEY environment variable or provide a secret."
    exit 1
fi

# Set the hostname from environment variable or use default
HOSTNAME=${TS_HOSTNAME:-"grafana-ts"}

echo "Authenticating to Tailscale network with hostname: $HOSTNAME"

# Try to authenticate to Tailscale
if ! tailscale up --authkey="$AUTHKEY" \
                 --hostname="$HOSTNAME" \
                 --accept-routes \
                 --ssh=false; then
    echo "ERROR: Failed to authenticate with Tailscale"
    echo "Tailscale daemon logs:"
    journalctl -u tailscaled -n 50 || echo "journalctl not available"
    exit 1
fi

# Print success message with IP
echo "Tailscale started successfully!"
tailscale status

# Default to Grafana if no command is provided
if [ $# -eq 0 ]; then
    echo "No CMD provided. Starting Grafana..."
    chown -R grafana:root /etc/grafana /var/lib/grafana
    exec su-exec grafana /run.sh

else
    echo "Starting with command: $@"
    exec "$@"
fi
