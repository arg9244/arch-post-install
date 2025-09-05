# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Repository Overview

This is an Arch Linux post-installation automation script that configures a fresh Arch Linux system with essential packages, system settings, and personal configuration files. The project follows a modular architecture with separate scripts for different configuration phases.

## Architecture

### Core Components

- **`install.sh`**: Main orchestrator script that executes all installation phases sequentially
- **`scripts/`**: Modular scripts for specific configuration tasks:
  - `install-packages.sh`: Handles package installation via paru (AUR helper)
  - `configure-system.sh`: System-level configurations (paru.conf, fstab, environment variables)
  - `configure-services.sh`: Systemd service management
  - `restore-configs.sh`: User configuration file restoration
- **`configs/`**: User configuration files organized by application

### Design Patterns

The project uses a **pipeline architecture** where each script handles a specific phase and can fail independently (using `set -e`). The main script orchestrates execution and provides colored output for user feedback.

## Essential Commands

### Running the Installation

**Full installation (recommended):**
```bash
./install.sh
```

**Manual step-by-step execution:**
```bash
# Install packages only
./scripts/install-packages.sh

# Configure system settings only
./scripts/configure-system.sh

# Configure services only
./scripts/configure-services.sh

# Restore configs only
./scripts/restore-configs.sh
```

### Development and Testing

**Make scripts executable:**
```bash
chmod +x install.sh
chmod +x scripts/*.sh
```

**Test individual components:**
```bash
# Dry run to see what packages would be installed
grep -A 30 'PACKAGES=(' scripts/install-packages.sh

# Check current paru configuration
cat /etc/paru.conf

# Verify fstab entries
cat /etc/fstab | grep -A 4 "arch-post-install"

# Check service status
systemctl status ananicy-cpp
```

## Critical Dependencies

- **paru**: AUR helper (script will fail without it)
- **sudo privileges**: Required for system modifications
- **Fresh Arch Linux installation**: Designed for clean installs
- **Internet connection**: For package downloads

## System Modifications

The script makes significant system changes:

1. **Package Manager Configuration**: Modifies `/etc/paru.conf` with BottomUp and SkipReview options
2. **Auto-mounting**: Adds entries to `/etc/fstab` for specific drive partitions:
   - `/dev/sda1` → `/mnt/D`
   - `/dev/sdb3` → `/mnt/E`
   - `/dev/nvme0n1p3` → `/mnt/C`
3. **AMD GPU Environment**: Sets `AMD_VULKAN_ICD=RADV` and `MESA_SHADER_CACHE_MAX_SIZE=12G` in `/etc/environment`
4. **Service Management**: Disables `ananicy-cpp` systemd service

## Configuration File Management

The `configs/` directory structure mirrors application config locations:

- **Lutris**: `~/.local/share/lutris/` (system.yml, lutris.conf, runners/wine.yml)
- **MPV**: `~/.config/mpv/` (entire directory)
- **Seanime**: `~/.config/Seanime/config.toml`

The restore script creates necessary directories and copies files conditionally (only if source files exist).

## Package Categories

The installation includes packages for:
- **Desktop Environment**: GDM, GNOME Control Center
- **Gaming**: Lutris, MangoHUD, GameScope, CachyOS Gaming Meta
- **Development**: Git, VS Code, Bun
- **Applications**: Ghostty, MPV, Zen Browser, Transmission
- **Utilities**: File managers, system monitors, archive tools

## Error Handling

All scripts use `set -e` for fail-fast behavior. The main script includes:
- Root user detection (exits if run as root)
- Paru installation verification
- Colored output for different message types (errors, success, info)

## Post-Installation Requirements

Users must manually:
1. Reboot system
2. Install GNOME extensions via Extension Manager
3. Place personal config files in `configs/` before running the script

## Backup Strategy

The script automatically creates backups for modified system files:
- `/etc/paru.conf.bak`
- `/etc/fstab.bak`
- `/etc/environment.bak`
