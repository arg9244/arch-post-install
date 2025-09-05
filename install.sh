#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}===========================================${NC}"
echo -e "${BLUE}    Arch Linux Post-Installation Script   ${NC}"
echo -e "${BLUE}===========================================${NC}"
echo ""

# Check if we're running from a downloaded script (via curl) or local clone
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [[ ! -d "$SCRIPT_DIR/scripts" ]]; then
    echo -e "${YELLOW}Cloning repository to get all required files...${NC}"
    
    # Check if git is installed
    if ! command -v git &> /dev/null; then
        echo -e "${RED}Error: git is not installed${NC}"
        echo "Please install git first: sudo pacman -S git"
        exit 1
    fi
    
    # Clone the repository
    REPO_DIR="$HOME/arch-post-install"
    if [[ -d "$REPO_DIR" ]]; then
        echo -e "${YELLOW}Repository already exists, updating...${NC}"
        cd "$REPO_DIR"
        git pull
    else
        git clone https://github.com/arg9244/arch-post-install.git "$REPO_DIR"
        cd "$REPO_DIR"
    fi
    
    # Update SCRIPT_DIR to the cloned repository
    SCRIPT_DIR="$REPO_DIR"
    
    echo -e "${GREEN}Repository cloned successfully!${NC}"
    echo ""
fi

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   echo -e "${RED}Error: This script should not be run as root${NC}"
   exit 1
fi

# Check if paru is installed
if ! command -v paru &> /dev/null; then
    echo -e "${RED}Error: paru AUR helper is not installed${NC}"
    echo "Please install paru first: https://github.com/Morganamilo/paru"
    exit 1
fi

echo -e "${YELLOW}Starting installation process...${NC}"
echo ""

# Step 1: Install packages
echo -e "${BLUE}Step 1: Installing packages...${NC}"
"$SCRIPT_DIR/scripts/install-packages.sh"
echo ""

# Step 2: Configure system settings
echo -e "${BLUE}Step 2: Configuring system settings...${NC}"
"$SCRIPT_DIR/scripts/configure-system.sh"
echo ""

# Step 3: Configure services
echo -e "${BLUE}Step 3: Configuring services...${NC}"
"$SCRIPT_DIR/scripts/configure-services.sh"
echo ""

# Step 4: Restore configuration files
echo -e "${BLUE}Step 4: Restoring configuration files...${NC}"
"$SCRIPT_DIR/scripts/restore-configs.sh"
echo ""

echo -e "${GREEN}===========================================${NC}"
echo -e "${GREEN}    Installation completed successfully!   ${NC}"
echo -e "${GREEN}===========================================${NC}"
echo ""
echo -e "${YELLOW}Post-installation notes:${NC}"
echo "1. Reboot your system to apply all changes"
echo "2. Install GNOME extensions manually:"
echo "   - App Indicator Support (appindicator)"
echo "   - Transmission Daemon Indicator NG"
echo "3. Configure your applications as needed"
echo ""
echo -e "${BLUE}Enjoy your new Arch Linux setup!${NC}"
