#!/bin/bash

# Mirror backups from local config to SMB share
rsync -avh /opt/mediastack/appdata/radarr/Backups/ /mnt/unraid/appdatabackup/radarr/
rsync -avh /opt/mediastack/appdata/sonarr-hd/Backups/ /mnt/unraid/appdatabackup/sonarr-hd/
rsync -avh /opt/mediastack/appdata/sonarr-4k/Backups/ /mnt/unraid/appdatabackup/sonarr-4k/
rsync -avh /opt/mediastack/appdata/whisparr/Backups/ /mnt/unraid/appdatabackup/whisparr/
rsync -avh /opt/mediastack/appdata/prowlarr/Backups/ /mnt/unraid/appdatabackup/prowlarr/
rsync -avh /opt/mediastack/appdata/sabnzbd/Backups/ /mnt/unraid/appdatabackup/sabnzbd/
