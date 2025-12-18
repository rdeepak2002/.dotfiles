# Dotfiles

Personal configuration files for ZSH, Vim, Ghostty terminal, and Moom window management.

## Features

### .zshrc
- **OS Detection**: Automatically detects macOS and only runs platform-specific commands
- **Auto-installation**: Automatically installs required brew packages on macOS
  - CLI tools: eza, bat, lazygit
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
- Config management via symlink to `$XDG_CONFIG_HOME/ghostty/config`
- Custom keybindings for split navigation (opt+h/j/k/l)
- Rose Pine theme with transparent background
- Blur effect for aesthetics
- **Note**: Ghostty must be installed manually (`brew install --cask ghostty`)

### Moom Window Layouts (macOS only)
- Saved window layout configurations for Moom
- **Ghostty Main.moom**: Window layout for Chrome, Safari, and Ghostty terminal
- **Note**: Version controlled for backup; manually import in Moom app when needed
- **Installation**: Moom must be installed separately (`brew install --cask moom`)

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

## What gets auto-installed (macOS only)

On first terminal launch, if you're on macOS, these tools will be auto-installed via Homebrew:
- **eza**: Modern replacement for ls
- **bat**: Modern replacement for cat with syntax highlighting
- **lazygit**: Terminal UI for git commands

## Prerequisites

- **Homebrew** (macOS): Required for auto-installation of CLI tools
- **Ghostty** (optional, macOS): Install manually with `brew install --cask ghostty` to use the included config
- **Moom** (optional, macOS): Install manually with `brew install --cask moom` to use the saved window layouts

## File Structure

```
~/.dotfiles/
├── .zshrc           # ZSH configuration
├── .vimrc           # Vim configuration
├── ghostty/
│   └── config       # Ghostty terminal config (macOS)
├── moom/
│   └── Ghostty Main.moom  # Moom window layout (macOS)
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


## Notes

- All brew installations happen silently (output to /dev/null) to keep terminal startup clean
- The setup script is idempotent - safe to run multiple times
- Platform-specific features are automatically detected and only run on appropriate systems
