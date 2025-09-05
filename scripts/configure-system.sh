#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo "=== Configuring System Settings ==="

# Configure paru.conf
echo "Configuring /etc/paru.conf..."
if [ -f /etc/paru.conf ]; then
    sudo cp /etc/paru.conf /etc/paru.conf.bak
    echo "Backup created: /etc/paru.conf.bak"
else
    echo -e "${YELLOW}Warning: /etc/paru.conf not found, creating default configuration${NC}"
    sudo touch /etc/paru.conf
fi

# Check if BottomUp is already uncommented
if ! grep -q "^BottomUp" /etc/paru.conf; then
    sudo sed -i 's/#BottomUp/BottomUp/' /etc/paru.conf
fi

# Check if SkipReview already exists
if ! grep -q "^SkipReview" /etc/paru.conf; then
    echo "SkipReview" | sudo tee -a /etc/paru.conf > /dev/null
fi

echo "✓ paru.conf configured"

# Configure fstab for automounting
echo "Configuring /etc/fstab for automounting..."
sudo cp /etc/fstab /etc/fstab.bak
echo "Backup created: /etc/fstab.bak"

# Create mount points
sudo mkdir -p /mnt/D /mnt/E /mnt/C

# Add automount entries to fstab (check for duplicates first)
if ! grep -q "arch-post-install script" /etc/fstab; then
    echo "# Auto-mount entries added by arch-post-install script" | sudo tee -a /etc/fstab > /dev/null
    echo "/dev/sda1    /mnt/D    auto    defaults,nofail    0 0" | sudo tee -a /etc/fstab > /dev/null
    echo "/dev/sdb3    /mnt/E    auto    defaults,nofail    0 0" | sudo tee -a /etc/fstab > /dev/null
    echo "/dev/nvme0n1p3    /mnt/C    auto    defaults,nofail    0 0" | sudo tee -a /etc/fstab > /dev/null
else
    echo -e "${YELLOW}Auto-mount entries already exist in fstab, skipping...${NC}"
fi

echo "✓ fstab configured for automounting"

# Configure environment variables
echo "Configuring /etc/environment..."
sudo cp /etc/environment /etc/environment.bak 2>/dev/null || true
echo "Backup created: /etc/environment.bak"

# Add environment variables (check for duplicates first)
if ! grep -q "AMD_VULKAN_ICD" /etc/environment; then
    echo "AMD_VULKAN_ICD=RADV" | sudo tee -a /etc/environment > /dev/null
fi

if ! grep -q "MESA_SHADER_CACHE_MAX_SIZE" /etc/environment; then
    echo "MESA_SHADER_CACHE_MAX_SIZE=12G" | sudo tee -a /etc/environment > /dev/null
fi

echo "✓ Environment variables configured"

echo "=== System configuration completed! ==="
