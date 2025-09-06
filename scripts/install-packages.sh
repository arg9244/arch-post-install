#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "=== Installing Required Packages ==="

# List of packages to install
PACKAGES=(
    gdm
    gnome-control-center
    extension-manager
    ghostty
    baobab
    loupe
    file-roller
    mpv
    resources
    zen-browser-bin
    hiddify-next-bin
    transmission-cli
    varia
    jdownloader2
    visual-studio-code-bin 
    bun-bin
    cachyos-gaming-meta
#    gamescope
#    goverlay
#    lutris
)

echo "Installing packages using paru..."
echo "Packages to install: ${PACKAGES[*]}"

# Install packages using paru (AUR helper)
if paru -S --needed --noconfirm "${PACKAGES[@]}"; then
    echo -e "${GREEN}✓ Package installation completed successfully!${NC}"
else
    echo -e "${RED}Error: Some packages failed to install${NC}"
    echo -e "${YELLOW}Continuing anyway - you may need to install failed packages manually${NC}"
fi
