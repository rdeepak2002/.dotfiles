#!/bin/bash

# Dotfiles setup script
# This script creates symlinks from home directory to dotfiles

set -e  # Exit on error

# Get the dotfiles directory (where this script is located)
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
HOME_DIR="$HOME"

echo "Setting up dotfiles from $DOTFILES_DIR"

# Function to create symlink with backup
create_symlink() {
    local source="$1"
    local target="$2"
    local filename=$(basename "$source")

    # Check if source file exists in dotfiles
    if [ ! -f "$source" ]; then
        echo "Warning: $filename not found in dotfiles directory, skipping..."
        return 0
    fi

    # If target exists and is not a symlink, back it up
    if [ -f "$target" ] && [ ! -L "$target" ]; then
        echo "Backing up existing $filename to ${filename}_backup"
        mv "$target" "${target}_backup"
    elif [ -L "$target" ]; then
        echo "Removing existing symlink for $filename"
        rm "$target"
    fi

    # Create the symlink
    echo "Creating symlink: $target -> $source"
    ln -s "$source" "$target"
}

# Create symlinks for each dotfile
create_symlink "$DOTFILES_DIR/.zshrc" "$HOME_DIR/.zshrc"
create_symlink "$DOTFILES_DIR/.vimrc" "$HOME_DIR/.vimrc"

# macOS-specific: Ghostty terminal config
if [[ "$(uname -s)" == "Darwin" ]]; then
    echo ""
    echo "Setting up Ghostty config (macOS)..."

    # Use XDG_CONFIG_HOME if set, otherwise default to ~/.config
    CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME_DIR/.config}"

    # Create ghostty config directory if it doesn't exist
    mkdir -p "$CONFIG_HOME/ghostty"

    # Create symlink for ghostty config
    create_symlink "$DOTFILES_DIR/ghostty/config" "$CONFIG_HOME/ghostty/config"
fi

echo ""
echo "✓ Dotfiles setup complete!"
echo ""
echo "Note: If you're on macOS, the .zshrc will auto-install brew packages on first shell launch."
