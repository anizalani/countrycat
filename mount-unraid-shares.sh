#!/bin/bash
# Mount SMB shares from Unraid to oracle-prime

# Set your variables
SMB_SERVER="unraid"   # <-- put Unraid's Tailscale IP here
SMB_USER="oracle"  # <-- SMB username
SMB_PASS="hpw6eyd-cxm!xfu.ZDT"  # <-- SMB password
MOUNT_BASE="/mnt/unraid"

# Install cifs-utils if missing
sudo apt update
sudo apt install -y cifs-utils

# List of shares
SHARES=(
  "3dprinting"
  "aniz"
  "appdatabackup"
  "backup"
  "books"
  "data"
  "downloads"
  "flynn"
  "ftpdata"
  "guacamole"
  "incomplete"
  "isla"
  "isos"
  "MacBook Pro Time Machine"
  "media"
  "movies"
  "music"
  "nextcloud"
  "nicole"
  "steam"
  "tv"
  "tv4k"
  "webdav"
  "YouTube"
)

# Create mount base
sudo mkdir -p "$MOUNT_BASE"

# Mount each share
for SHARE in "${SHARES[@]}"; do
  SAFE_SHARE=$(echo "$SHARE" | sed 's/ /_/g') # Replace spaces with underscore
  sudo mkdir -p "$MOUNT_BASE/$SAFE_SHARE"
  sudo mount.cifs "//$SMB_SERVER/$SHARE" "$MOUNT_BASE/$SAFE_SHARE" -o username=$SMB_USER,password=$SMB_PASS,vers=3.0,iocharset=utf8,uid=1000,gid=1000
done

# Optional: Add to /etc/fstab for persistence
for SHARE in "${SHARES[@]}"; do
  SAFE_SHARE=$(echo "$SHARE" | sed 's/ /_/g')
  echo "//$SMB_SERVER/$SHARE $MOUNT_BASE/$SAFE_SHARE cifs username=$SMB_USER,password=$SMB_PASS,vers=3.0,iocharset=utf8,uid=1000,gid=1000 0 0" | sudo tee -a /etc/fstab
done
