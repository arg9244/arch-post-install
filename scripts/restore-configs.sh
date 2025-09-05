#!/bin/bash

set -e

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
    echo "✓ Lutris system.yml copied"
fi

if [ -f "$CONFIG_DIR/lutris/lutris.conf" ]; then
    cp "$CONFIG_DIR/lutris/lutris.conf" ~/.local/share/lutris/
    echo "✓ Lutris config copied"
fi

if [ -f "$CONFIG_DIR/lutris/runners/wine.yml" ]; then
    mkdir -p ~/.local/share/lutris/runners
    cp "$CONFIG_DIR/lutris/runners/wine.yml" ~/.local/share/lutris/runners/
    echo "✓ Lutris wine runner config copied"
fi

# Copy MPV config
if [ -d "$CONFIG_DIR/mpv" ]; then
    cp -r "$CONFIG_DIR/mpv" ~/.config/
    echo "✓ MPV config copied"
fi

# Copy Seanime config
if [ -f "$CONFIG_DIR/Seanime/config.toml" ]; then
    mkdir -p ~/.config/Seanime
    cp "$CONFIG_DIR/Seanime/config.toml" ~/.config/Seanime/
    echo "✓ Seanime config copied"
fi

echo "=== Configuration files restoration completed! ==="
