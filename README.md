# Dotfiles Setup

Complete development environment setup for Ubuntu/Linux systems with all essential tools, languages, and configurations.

## Quick Start

```bash
cd dotfiles
chmod +x install.sh
./install.sh
```

The script will:
- Update system packages
- Install dev tools (C++, Python, Rust, Docker, clang)
- Install CLI utilities (fzf, ripgrep, curl, git, lsd, bat, etc.)
- Install NVM and Bun
- Install VS Code and Spotify
- Configure bash, git, and VS Code settings
- Backup existing configurations

## What Gets Installed

### Development Tools
- **C++**: g++, clang, gdb, cmake, make, build-essential
- **Python 3**: with pip, venv, and development headers
- **Rust**: (optional - can be added to install.sh)
- **Docker**: with post-install group setup
- **Node.js**: Latest LTS via NVM
- **Bun**: Fast JavaScript runtime

### CLI Tools
- git, curl, wget
- fzf (fuzzy finder)
- ripgrep (fast search)
- lsd (better ls)
- bat (better cat)
- vim, tmux, htop
- jq (JSON processor)

### Applications
- VS Code (with recommended extensions)
- Spotify

## Post-Installation

1. **Configure git user** (required for commits):
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your@email.com"
   ```

2. **Docker permissions** (if Docker was installed):
   ```bash
   newgrp docker
   # OR log out and back in
   ```

3. **Reload environment**:
   ```bash
   source ~/.bashrc
   ```

4. **VS Code Setup**:
   - Sign in to sync settings
   - Install recommended extensions (will be prompted)
   - Recommended extensions include: Prettier, ESLint, Python, Rust Analyzer, GitLens, Docker

## File Organization

```
dotfiles/
├── install.sh              # Main installation script
├── .bashrc                 # Bash configuration with aliases
├── .gitconfig              # Git configuration
├── .gitignore_global       # Global gitignore patterns
├── vscode-settings.json    # VS Code settings
└── README.md              # This file
```

## Aliases Included

### Productivity
- `g` - git
- `ga` - git add
- `gc` - git commit
- `gp` - git push
- `gs` - git status
- `gl` - git log --oneline -10
- `cl` - clear
- `reload` - source ~/.bashrc
- `mkd` - mkdir -p

### Better Defaults
- `ls` - lsd (colorful list)
- `cat` - batcat (with syntax highlighting)
- `bat` - batcat

### Navigation
- `..` - cd ..
- `...` - cd ../..
- `....` - cd ../../..

## Customization

- Edit `.bashrc` to add aliases or environment variables
- Edit `vscode-settings.json` for VS Code preferences
- Modify `install.sh` to add/remove tools

### Adding Rust

To add Rust support, add this to `install.sh` after the Python section:

```bash
# Install Rust
if ! command -v rustc &> /dev/null; then
  log_info "Installing Rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
else
  log_success "Rust already installed"
fi
```

## Backup

The script automatically backs up existing configs with timestamps:
- `~/.bashrc.backup.YYYYMMDD_HHMMSS`
- `~/.gitconfig.backup.YYYYMMDD_HHMMSS`

To restore a backup:
```bash
cp ~/.bashrc.backup.YYYYMMDD_HHMMSS ~/.bashrc
cp ~/.gitconfig.backup.YYYYMMDD_HHMMSS ~/.gitconfig
source ~/.bashrc
```

## Environment Variables

The following are automatically configured:
- `NVM_DIR` - Node Version Manager directory
- `BUN_INSTALL` - Bun installation directory
- `PATH` - Updated to include local bin, Bun, and NVM

## Troubleshooting

**Docker permission denied?**
- Run: `newgrp docker` or restart your session

**NVM not found?**
- Run: `source ~/.bashrc` or restart terminal

**Spotify installation fails?**
- The Spotify repo may have changed; manually install from snap:
  ```bash
  sudo snap install spotify
  ```

**Bun not found after install?**
- Run: `source ~/.bashrc` and verify `$PATH` includes `~/.bun/bin`

**bat/lsd commands not found?**
- Run: `source ~/.bashrc`

## Version Info

Last updated: December 2024
- Ubuntu/Linux Mint (any recent version)
- NVM: v0.39.0+
- Bun: Latest stable
- VS Code: Latest from Microsoft repos
- Docker: Latest from apt

## Tips

- Use `fzf` for fuzzy file searching in terminal
- Use `ripgrep` (rg) for faster code searching
- Use `git-graph` VS Code extension to visualize git history
- Use `GitLens` to see code authorship and history

## Contributing

Feel free to fork and customize for your needs!
