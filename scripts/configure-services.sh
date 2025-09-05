#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "=== Configuring Services ==="

# Disable ananicy-cpp service
echo "Disabling ananicy-cpp service..."
if systemctl is-enabled ananicy-cpp &>/dev/null; then
    sudo systemctl disable --now ananicy-cpp
    echo -e "${GREEN}✓ ananicy-cpp disabled${NC}"
else
    echo -e "${YELLOW}ananicy-cpp is not enabled or not installed${NC}"
fi

echo "=== Service configuration completed! ==="
