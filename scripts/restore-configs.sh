#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "=== Restoring Configuration Files ==="

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="$SCRIPT_DIR/../configs"

# Create necessary directories
mkdir -p ~/.local/share/lutris
mkdir -p ~/.config

echo "Copying configuration files..."

# Copy Lutris configs
if [ -f "$CONFIG_DIR/lutris/system.yml" ]; then
    cp "$CONFIG_DIR/lutris/system.yml" ~/.local/share/lutris/
    echo -e "${GREEN}✓ Lutris system.yml copied${NC}"
else
    echo -e "${YELLOW}Warning: Lutris system.yml not found${NC}"
fi

if [ -f "$CONFIG_DIR/lutris/lutris.conf" ]; then
    cp "$CONFIG_DIR/lutris/lutris.conf" ~/.local/share/lutris/
    echo -e "${GREEN}✓ Lutris config copied${NC}"
else
    echo -e "${YELLOW}Warning: Lutris config not found${NC}"
fi

if [ -f "$CONFIG_DIR/lutris/runners/wine.yml" ]; then
    mkdir -p ~/.local/share/lutris/runners
    cp "$CONFIG_DIR/lutris/runners/wine.yml" ~/.local/share/lutris/runners/
    echo -e "${GREEN}✓ Lutris wine runner config copied${NC}"
else
    echo -e "${YELLOW}Warning: Lutris wine runner config not found${NC}"
fi

# Copy MPV config
if [ -d "$CONFIG_DIR/mpv" ]; then
    cp -r "$CONFIG_DIR/mpv" ~/.config/
    echo -e "${GREEN}✓ MPV config copied${NC}"
else
    echo -e "${YELLOW}Warning: MPV config directory not found${NC}"
fi

# Copy Seanime config
if [ -f "$CONFIG_DIR/Seanime/config.toml" ]; then
    mkdir -p ~/.config/Seanime
    cp "$CONFIG_DIR/Seanime/config.toml" ~/.config/Seanime/
    echo -e "${GREEN}✓ Seanime config copied${NC}"
else
    echo -e "${YELLOW}Warning: Seanime config not found${NC}"
fi

echo "=== Configuration files restoration completed! ==="
