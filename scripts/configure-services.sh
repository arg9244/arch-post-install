#!/bin/bash

set -e

echo "=== Configuring Services ==="

# Disable ananicy-cpp service
echo "Disabling ananicy-cpp service..."
if systemctl is-enabled ananicy-cpp &>/dev/null; then
    sudo systemctl disable --now ananicy-cpp
    echo "✓ ananicy-cpp disabled"
else
    echo "ananicy-cpp is not enabled or not installed"
fi

echo "=== Service configuration completed! ==="
