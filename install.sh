#!/bin/bash

# Dotfiles installation script for Ubuntu/Linux Mint
# This script sets up development tools, CLI utilities, and applications
# Run with: chmod +x install.sh && ./install.sh

set -e

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
log_success() { echo -e "${GREEN}✅ $1${NC}"; }
log_warn() { echo -e "${YELLOW}⚠️  $1${NC}"; }
log_error() { echo -e "${RED}❌ $1${NC}"; }

log_info "Starting dotfiles setup for $(whoami)@$(hostname)..."

# Update system
log_info "Updating package manager..."
sudo apt update && sudo apt upgrade -y

# Install system dependencies
log_info "Installing system dependencies..."
sudo apt install -y \
  build-essential \
  git \
  curl \
  wget \
  vim \
  tmux \
  htop \
  fzf \
  ripgrep \
  jq \
  lsd \
  bat

# Install C++ development kit
log_info "Installing C++ development kit..."
sudo apt install -y \
  g++ \
  gdb \
  cmake \
  make \
  clang

# Install Python
log_info "Installing Python..."
sudo apt install -y \
  python3 \
  python3-pip \
  python3-venv \
  python3-dev

# Install Docker
if ! command -v docker &> /dev/null; then
  log_info "Installing Docker..."
  sudo apt install -y docker.io
  sudo usermod -aG docker $USER
  log_warn "Docker installed! You may need to log out and back in to use Docker without sudo, or run: newgrp docker"
else
  log_success "Docker already installed"
fi

# Install NVM (if not already installed)
if [ ! -d "$HOME/.nvm" ]; then
  log_info "Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  log_info "Installing latest Node.js LTS..."
  nvm install --lts
  nvm use --lts
else
  log_success "NVM already installed"
fi

# Install Bun (if not already installed)
if ! command -v bun &> /dev/null; then
  log_info "Installing Bun..."
  curl -fsSL https://bun.sh/install | bash
  log_warn "Bun installed! Run 'source ~/.bashrc' to update PATH"
else
  log_success "Bun already installed"
fi

# Install Spotify
if ! command -v spotify &> /dev/null; then
  log_info "Installing Spotify..."
  curl -sS https://download.spotify.com/linux/keys/spotifylinuxrepo.gpg | sudo apt-key add -
  echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt update && sudo apt install -y spotify-client
  log_success "Spotify installed"
else
  log_success "Spotify already installed"
fi

# Install VS Code
if ! command -v code &> /dev/null; then
  log_info "Installing VS Code..."
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /tmp/microsoft.gpg
  sudo install -o root -g root -m 644 /tmp/microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
  sudo apt update && sudo apt install -y code
  rm /tmp/microsoft.gpg
  log_success "VS Code installed"
else
  log_success "VS Code already installed"
fi

# Install dotfiles configs
log_info "Installing configuration files..."
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Backup existing configs with timestamp
BACKUP_TIMESTAMP=$(date +%Y%m%d_%H%M%S)
[ -f "$HOME/.bashrc" ] && cp "$HOME/.bashrc" "$HOME/.bashrc.backup.$BACKUP_TIMESTAMP" && log_warn "Backed up .bashrc to .bashrc.backup.$BACKUP_TIMESTAMP"
[ -f "$HOME/.gitconfig" ] && cp "$HOME/.gitconfig" "$HOME/.gitconfig.backup.$BACKUP_TIMESTAMP" && log_warn "Backed up .gitconfig to .gitconfig.backup.$BACKUP_TIMESTAMP"

# Copy configs
cp "$SCRIPT_DIR/.bashrc" "$HOME/.bashrc"
cp "$SCRIPT_DIR/.gitconfig" "$HOME/.gitconfig"
mkdir -p "$HOME/.config/Code/User"
cp "$SCRIPT_DIR/vscode-settings.json" "$HOME/.config/Code/User/settings.json"

log_success "Configuration files installed"

# Source bashrc
source "$HOME/.bashrc"

echo ""
log_success "Setup complete!"
echo ""
log_info "Next steps:"
echo "1. Configure git user:"
echo "   git config --global user.name 'Your Name'"
echo "   git config --global user.email 'your@email.com'"
echo "2. If Docker was installed, log out and back in or run: newgrp docker"
echo "3. Reload environment: source ~/.bashrc"
echo "4. Sign in to VS Code and install recommended extensions"
echo ""
