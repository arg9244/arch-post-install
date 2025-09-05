# Arch Linux Post-Installation Script

An automated script to configure a fresh Arch Linux installation with essential packages, system settings, and configurations.

## Quick Installation

Run this command in your terminal after a fresh Arch Linux installation:

**Quick install (shorter command - easier to type in TTY):**
```bash
curl -fsSL github.com/arg9244/arch-post-install/raw/master/i|bash
```

**Alternative short command:**
```bash
curl -fsSL github.com/arg9244/arch-post-install/raw/master/install.sh|bash
```

**Full command (original):**
```bash
curl -fsSL https://raw.githubusercontent.com/arg9244/arch-post-install/master/install.sh | bash
```

> **💡 Tip:** The quick install command (`i`) is recommended for fresh installs as it's much shorter to type in TTY. All commands do the same thing: automatically clone the repository, install dependencies, and run the full installation.

**Or clone and run manually:**

```bash
git clone https://github.com/arg9244/arch-post-install.git
cd arch-post-install
chmod +x install.sh
./install.sh
```

## What This Script Does

### 1. Package Installation
Installs essential packages including:
- **Desktop Environment**: GDM, GNOME Control Center
- **Applications**: Ghostty, MPV, VS Code, Alacritty, PCManFM
- **Gaming**: Lutris, MangoHUD, GameScope, CachyOS Gaming Meta
- **Development**: Git, Bun
- **Utilities**: Baobab, Loupe, File Roller, Resources
- **Browsers**: Zen Browser
- **Other**: Transmission, JDownloader, Extension Manager

### 2. System Configuration
- Configures `/etc/paru.conf` with BottomUp and SkipReview options
- Sets up automatic mounting for drives:
  - `/dev/sda1` → `/mnt/D`
  - `/dev/sdb3` → `/mnt/E`
  - `/dev/nvme0n1p3` → `/mnt/C`
- Adds AMD GPU environment variables to `/etc/environment`

### 3. Service Management
- Disables `ananicy-cpp` service

### 4. Configuration Files
Restores your personal configuration files for:
- Lutris (system.yml, lutris.conf, wine.yml)
- MPV configuration
- Seanime configuration

## Prerequisites

- Fresh Arch Linux installation
- `paru` AUR helper installed (script will check and guide you if missing)
- Internet connection
- Non-root user with sudo privileges

> **Note:** The script automatically handles git installation if needed and clones the repository for you.

## Manual Steps Required

After running the script, you'll need to manually:

1. **Install GNOME Extensions** via Extension Manager:
   - App Indicator Support
   - Transmission Daemon Indicator NG

2. **Reboot your system** to apply all changes

3. **Add your configuration files** to the `configs/` directory before running the script

## Project Structure

```
arch-post-install/
├── install.sh              # Main installation script
├── scripts/
│   ├── install-packages.sh  # Package installation
│   ├── configure-system.sh  # System configuration
│   ├── configure-services.sh # Service management
│   └── restore-configs.sh   # Configuration restoration
├── configs/
│   ├── lutris/             # Lutris configurations
│   ├── mpv/               # MPV configuration
│   └── Seanime/           # Seanime configuration
└── README.md              # This file
```

## Configuration Files Setup

Before running the script, place your configuration files in the appropriate directories:

- `configs/lutris/system.yml` - Lutris system configuration
- `configs/lutris/lutris.conf` - Lutris main configuration
- `configs/lutris/runners/wine.yml` - Wine runner configuration
- `configs/mpv/` - Complete MPV configuration directory
- `configs/Seanime/config.toml` - Seanime configuration file

## Troubleshooting

### Script fails at package installation
- Ensure `paru` is installed and working
- Check your internet connection
- Some AUR packages might take time to build

### Permission denied errors
- Don't run the script as root
- Ensure your user has sudo privileges

### Configuration files not found
- Make sure to place your config files in the `configs/` directory structure
- The script will skip missing configuration files

## Contributing

Feel free to submit issues and enhancement requests!

## License

This project is open source and available under the MIT License.
