#!/bin/bash

set -e

echo "=== Configuring System Settings ==="

# Configure paru.conf
echo "Configuring /etc/paru.conf..."
if [ -f /etc/paru.conf ]; then
    sudo cp /etc/paru.conf /etc/paru.conf.bak
    echo "Backup created: /etc/paru.conf.bak"
fi

sudo sed -i 's/#BottomUp/BottomUp/' /etc/paru.conf
echo "SkipReview" | sudo tee -a /etc/paru.conf > /dev/null

echo "✓ paru.conf configured"

# Configure fstab for automounting
echo "Configuring /etc/fstab for automounting..."
sudo cp /etc/fstab /etc/fstab.bak
echo "Backup created: /etc/fstab.bak"

# Create mount points
sudo mkdir -p /mnt/D /mnt/E /mnt/C

# Add automount entries to fstab
echo "# Auto-mount entries added by arch-post-install script" | sudo tee -a /etc/fstab > /dev/null
echo "/dev/sda1    /mnt/D    auto    defaults,nofail    0 0" | sudo tee -a /etc/fstab > /dev/null
echo "/dev/sdb3    /mnt/E    auto    defaults,nofail    0 0" | sudo tee -a /etc/fstab > /dev/null
echo "/dev/nvme0n1p3    /mnt/C    auto    defaults,nofail    0 0" | sudo tee -a /etc/fstab > /dev/null

echo "✓ fstab configured for automounting"

# Configure environment variables
echo "Configuring /etc/environment..."
sudo cp /etc/environment /etc/environment.bak 2>/dev/null || true
echo "Backup created: /etc/environment.bak"

echo "AMD_VULKAN_ICD=RADV" | sudo tee -a /etc/environment > /dev/null
echo "MESA_SHADER_CACHE_MAX_SIZE=12G" | sudo tee -a /etc/environment > /dev/null

echo "✓ Environment variables configured"

echo "=== System configuration completed! ==="
