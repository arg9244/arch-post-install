#!/bin/bash

set -e

echo "=== Installing Required Packages ==="

# List of packages to install
PACKAGES=(
    gdm
    gnome-control-center
    ghostty
    baobab
    loupe
    file-roller
    mpv
    resources
    zen-browser-bin
    throne
    transmission
    jdownloader
    git
    code
    bun-bin
    cachyos-gaming-meta
    gamescope
    goverlay
    lib32-mangohud
    lutris
    mangohud
    wqy-zenhei
    alacritty
    pcmanfm
    extension-manager
)

echo "Installing packages using paru..."
echo "Packages to install: ${PACKAGES[*]}"

# Install packages using paru (AUR helper)
paru -S --needed --noconfirm "${PACKAGES[@]}"

echo "✓ Package installation completed successfully!"
