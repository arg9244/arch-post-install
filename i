#!/bin/bash
# Arch Linux Post-Install Script Launcher
# Usage: curl -fsSL github.com/arg9244/arch-post-install/raw/master/get | bash

set -e

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "Installing git..."
    sudo pacman -S --noconfirm git
fi

# Clone and run the installer
REPO_DIR="$HOME/arch-post-install"
if [[ -d "$REPO_DIR" ]]; then
    echo "Repository exists, updating..."
    cd "$REPO_DIR"
    git pull
else
    echo "Cloning repository..."
    git clone https://github.com/arg9244/arch-post-install.git "$REPO_DIR"
    cd "$REPO_DIR"
fi

echo "Running installation..."
./install.sh
