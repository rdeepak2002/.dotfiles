# Dotfiles

Personal configuration files for ZSH, Vim, and Ghostty terminal.

## Features

### .zshrc
- **OS Detection**: Automatically detects macOS and only runs platform-specific commands
- **Auto-installation**: Automatically installs required brew packages on macOS
  - CLI tools: eza, bat, lazygit
  - Terminal: ghostty (cask)
- **Modern CLI tools**: Aliased for better command-line experience
- **ZSH completion**: Enhanced menu-based completion
- **NVM & SDKMAN**: Automatic initialization if installed

### .vimrc
- Vim-Plug package manager with curated plugins
- IDE-like features with CoC (Conquer of Completion)
- NERDTree file explorer
- Enhanced keyboard shortcuts
- Syntax highlighting and modern themes

### Ghostty Config (macOS only)
- Custom keybindings for split navigation (opt+h/j/k/l)
- Rose Pine theme with transparent background
- Blur effect for aesthetics

## Installation

1. Clone this repository:
```bash
git clone https://github.com/rdeepak2002/.dotfiles.git ~/.dotfiles
```

2. Run the setup script:
```bash
cd ~/.dotfiles
./setup.sh
```

The setup script will:
- Backup any existing dotfiles (as `.filename_backup`)
- Create symlinks from your home directory to the dotfiles
- Handle macOS-specific configs (Ghostty) automatically
- Handle missing files gracefully

3. Restart your terminal or source the config:
```bash
source ~/.zshrc
```

## What gets installed (macOS only)

On first terminal launch, if you're on macOS, these tools will be auto-installed via Homebrew:
- **eza**: Modern replacement for ls
- **bat**: Modern replacement for cat with syntax highlighting
- **lazygit**: Terminal UI for git commands
- **ghostty**: Modern terminal emulator (cask)

## File Structure

```
~/.dotfiles/
├── .zshrc           # ZSH configuration
├── .vimrc           # Vim configuration
├── ghostty/
│   └── config       # Ghostty terminal config (macOS)
├── setup.sh         # Installation script
└── README.md        # This file
```

## Symlinks Created

- `~/.zshrc` → `~/.dotfiles/.zshrc`
- `~/.vimrc` → `~/.dotfiles/.vimrc`
- `$XDG_CONFIG_HOME/ghostty/config` → `~/.dotfiles/ghostty/config` (macOS only)

## Customization

Edit the files in `~/.dotfiles/` and changes will automatically apply (they're symlinked). For ZSH changes, restart your terminal or run `source ~/.zshrc`.

## Manual Installation

If you prefer to manually set up symlinks:
```bash
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.vimrc ~/.vimrc

# macOS only:
mkdir -p ${XDG_CONFIG_HOME:-~/.config}/ghostty
ln -s ~/.dotfiles/ghostty/config ${XDG_CONFIG_HOME:-~/.config}/ghostty/config
```

## Requirements

- **macOS**: Homebrew for auto-installation of tools
- **Other OS**: The .zshrc will work but won't auto-install packages

## Notes

- All brew installations happen silently (output to /dev/null) to keep terminal startup clean
- The setup script is idempotent - safe to run multiple times
- Platform-specific features are automatically detected and only run on appropriate systems
