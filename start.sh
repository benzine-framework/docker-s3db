#!/usr/bin/env bash

# Fix for windows hosts manging run files
dos2unix /etc/service/*/run

# Fix permissions on run files
chmod +x /etc/service/*/run

# Start Runit.
echo "Starting Runit."
runsvdir -P /etc/service