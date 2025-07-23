# Load Pure
fpath+=("$HOME/.zsh/zsh-async")
fpath+=("$HOME/.zsh/pure")

autoload -U promptinit; promptinit
prompt pure

export GDK_SCALE=2
export GDK_DPI_SCALE=0.5
export QT_SCALE_FACTOR=2


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# No theme since using starship
ZSH_THEME=""

# Fixes conda error
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1
export PATH="$HOME/.local/bin:$PATH"

# zsh completions
fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
autoload -U compinit && compinit

# Plugins
plugins=(git zsh-autosuggestions fast-syntax-highlighting zsh-autocomplete )
source $ZSH/oh-my-zsh.sh

# Aliases
alias ls="eza --icons --colour -G -l -ahB"

# History
SAVEHIST=1000  # Save most-recent 1000 lines
HISTFILE=~/.zsh_history

# NVIM
export EDITOR='nvim'

# tmuxifier
export PATH="$HOME/.tmuxifier/bin:$PATH"
eval "$(tmuxifier init -)"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/chris/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/chris/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/chris/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/chris/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# redis cli completions
compdef '_dispatch redis-cli_completion redis-cli' valkey-cli

export PATH=$PATH:/home/chris/.spicetify

export TERM=xterm-256color

# noise torch
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

#pyenv
eval "$(pyenv init - zsh)"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

# homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"


