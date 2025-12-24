#!/bin/bash

# Dotfiles installation script
# This script sets up your development environment to match this system

set -e

echo "🚀 Starting dotfiles setup..."

# Update system
echo "📦 Updating package manager..."
sudo apt update && sudo apt upgrade -y

# Install system dependencies
echo "📦 Installing system dependencies..."
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

# Install C++ development
echo "📦 Installing C++ development tools..."
sudo apt install -y \
  g++ \
  gdb \
  cmake \
  make

# Install Python
echo "📦 Installing Python..."
sudo apt install -y \
  python3 \
  python3-pip \
  python3-venv

# Install NVM (if not already installed)
if [ ! -d "$HOME/.nvm" ]; then
  echo "📦 Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  nvm install node
else
  echo "✅ NVM already installed"
fi

# Install Bun (if not already installed)
if ! command -v bun &> /dev/null; then
  echo "📦 Installing Bun..."
  curl -fsSL https://bun.sh/install | bash
else
  echo "✅ Bun already installed"
fi

# Install VS Code
if ! command -v code &> /dev/null; then
  echo "📦 Installing VS Code..."
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
  sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
  sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
  sudo apt update && sudo apt install -y code
  rm microsoft.gpg
else
  echo "✅ VS Code already installed"
fi

# Install dotfiles configs
echo "🔧 Installing configuration files..."
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Backup existing configs
[ -f "$HOME/.bashrc" ] && cp "$HOME/.bashrc" "$HOME/.bashrc.backup"
[ -f "$HOME/.gitconfig" ] && cp "$HOME/.gitconfig" "$HOME/.gitconfig.backup"

# Copy configs
cp "$SCRIPT_DIR/.bashrc" "$HOME/.bashrc"
cp "$SCRIPT_DIR/.gitconfig" "$HOME/.gitconfig"
mkdir -p "$HOME/.config/Code/User"
cp "$SCRIPT_DIR/vscode-settings.json" "$HOME/.config/Code/User/settings.json"

echo "✅ Configuration files installed"

# Source bashrc
source "$HOME/.bashrc"

echo ""
echo "✨ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Reload environment: source ~/.bashrc"
echo "2. Sign in to VS Code"
echo "3. Install VS Code extensions from Extensions view"
