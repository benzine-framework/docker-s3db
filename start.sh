#!/usr/bin/env bash

# Fix for windows hosts manging run files
dos2unix /etc/service/*/run

# Fix permissions on run files
chmod +x /etc/service/*/run

# Define shutdown + cleanup procedure
cleanup() {
    echo "Container stop requested, running final dump + cleanup"
    /sync/sync --push
    echo "Good bye!"
}

# Trap SIGTERM
echo "Setting SIGTERM trap"
trap 'cleanup' EXIT SIGINT
trap 'echo SIGQUIT' SIGQUIT

# Start Runit.
echo "Starting Runit."
runsvdir -P /etc/service