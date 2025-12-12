# Dotfiles Setup

Complete development environment setup for Linux Mint with all essential tools, languages, and configurations.

## Quick Start

```bash
cd dotfiles
chmod +x install.sh
./install.sh
```

The script will:
- Update system packages
- Install dev tools (C++, Python, Rust, Docker)
- Install CLI utilities (fzf, ripgrep, curl, git, etc.)
- Install NVM and Bun
- Install VS Code and Spotify
- Configure bash, git, and VS Code settings

## What Gets Installed

### Development Tools
- **C++**: g++, gdb, cmake, make
- **Python 3**: with pip and venv
- **Docker**: with post-install group setup
- **Node.js**: via NVM
- **Bun**: Fast JavaScript runtime

### CLI Tools
- git, curl, wget
- fzf (fuzzy finder)
- ripgrep (fast search)
- vim, tmux, htop
- jq (JSON processor)

### Applications
- VS Code
- Spotify

## Post-Installation

1. **Restart your shell or log out/in** for Docker permissions:
   ```bash
   newgrp docker
   ```

2. **Configure git user** (required for commits):
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your@email.com"
   ```

3. **VS Code Extensions** (recommended):
   - Prettier - Code formatter
   - ESLint
   - Python
   - Rust Analyzer
   - C/C++ (Microsoft)
   - Material Theme
   - vscode-icons

   Or install automatically by opening VS Code and it should suggest recommended extensions.

## File Organization

```
dotfiles/
├── install.sh              # Main installation script
├── .bashrc                 # Bash configuration
├── .gitconfig              # Git configuration
├── .gitignore_global       # Global gitignore patterns
├── vscode-settings.json    # VS Code settings
└── README.md              # This file
```

## Customization

- Edit `.bashrc` to add aliases or environment variables
- Edit `vscode-settings.json` for VS Code preferences
- Modify `install.sh` to add/remove tools

## Backup

The script automatically backs up existing configs:
- `~/.bashrc.backup`
- `~/.gitconfig.backup`

## Uninstall/Reset

To restore backups:
```bash
cp ~/.bashrc.backup ~/.bashrc
cp ~/.gitconfig.backup ~/.gitconfig
```

## Version Info

Last updated: December 2024
- NVM: v0.39.0+
- Bun: Latest
- VS Code: Latest
- Docker: Latest from apt

## Troubleshooting

**Docker permission denied?** 
- Restart shell or run: `newgrp docker`

**NVM not found?**
- Run: `source ~/.bashrc` or restart terminal

**Spotify repo key error?**
- The repo may have changed; update the install script

**Bun not found after install?**
- Run: `source ~/.bashrc` and verify `$PATH` includes `~/.bun/bin`
