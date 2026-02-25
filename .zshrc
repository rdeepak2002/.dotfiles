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

# Pyenv setup (if exists)
# Usage:
#   pyls              - list installed python versions
#   pyuse 3.13.3      - switch to python 3.13.3
#   pyuse system      - switch back to system python
#   pyenv install 3.12 - install a new python version
if command -v pyenv &> /dev/null; then
    export PYENV_ROOT="$HOME/.pyenv"
    # Remove Python.org framework paths so pyenv takes priority
    PATH=$(echo "$PATH" | tr ':' '\n' | grep -v '/Library/Frameworks/Python.framework' | tr '\n' ':' | sed 's/:$//')
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    alias pyls='pyenv versions'
    alias pyuse='pyenv global'
fi

export PATH=$PATH:/Users/deepakramalingam/.local/bin

alias scratchpad='nvim $(mktemp)'

alias clauded="claude --dangerously-skip-permissions"

alias claudet='claude --allowedTools "Bash,Read,Write,Edit,Grep,WebQuery,WebSearch,ssh"'

function mcurl() {
  curl -k \
    --key ~/.metatron/certificates/user.key \
    --cert ~/.metatron/certificates/user.crt \
    --cacert ~/.metatron/certificates/metatronClient.trust.pem \
    "$@"
}

