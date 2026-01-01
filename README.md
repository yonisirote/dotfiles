# Dotfiles Setup

Quick setup for development environment with essential tools and configurations.

## Quick Start

```bash
cd dotfiles
chmod +x install.sh
./install.sh
```

The script will:
- Update system packages
- Install development tools (C++, Python, Node.js, Bun)
- Install CLI utilities (git, ripgrep, lsd, bat, etc.)
- Install VS Code
- Configure bash, git, and VS Code settings

## What Gets Installed

### Development Tools
- C++: g++, gdb, cmake, make
- Python 3: with pip and venv
- Node.js: via NVM
- Bun: Fast JavaScript runtime

### CLI Tools
- git, curl, wget, vim, tmux, btop
- ripgrep (fast search)
- lsd (better ls) (optional)
- bat (better cat) (optional)
- jq (JSON processor)

### Applications
- VS Code

## Post-Installation

1. **Reload shell environment**:
   ```bash
   source ~/.bashrc
   ```

2. **Configure git** (if not already set):
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your@email.com"
   ```

3. **VS Code Setup**:
   - Sign in to sync your settings
   - Install your preferred extensions

## File Organization

```
dotfiles/
├── install.sh              # Installation script
├── .bashrc                 # Bash configuration
├── .gitconfig              # Git configuration
├── vscode-settings.json    # VS Code settings
└── README.md               # This file
```

## Customization

- Edit `.bashrc` to add aliases or environment variables
- Edit `vscode-settings.json` for VS Code preferences
- Modify `install.sh` to add/remove tools (edit this to your taste)

## Backup

The script automatically backs up existing configs:
- `~/.bashrc.backup`
- `~/.gitconfig.backup`

To restore:
```bash
cp ~/.bashrc.backup ~/.bashrc
cp ~/.gitconfig.backup ~/.gitconfig
```
