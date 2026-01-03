# Detect OS
OS="$(uname -s)"

# macOS-specific setup
if [[ "$OS" == "Darwin" ]]; then
    # Function to check and install brew packages
    install_if_missing() {
        if ! command -v $1 &> /dev/null; then
            echo "Installing $1..." >&2
            brew install $1 &> /dev/null
        fi
    }

    # Install and setup modern CLI tools
    install_if_missing eza
    install_if_missing bat
    install_if_missing lazygit
fi

# Aliases (only set if commands exist)
command -v eza &> /dev/null && alias ls=eza
command -v bat &> /dev/null && alias cat=bat
command -v lazygit &> /dev/null && alias lg=lazygit

# ZSH completion setup
zstyle ':completion:*' menu select
fpath+=~/.zfunc; autoload -Uz compinit; compinit

# NVM setup (if exists)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# SDKMAN setup (if exists)
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH=$PATH:/Users/deepakramalingam/.local/bin
