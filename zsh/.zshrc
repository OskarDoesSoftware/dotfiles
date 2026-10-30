
PROMPT='%F{cyan}%n%f %F{magenta}%~%f %F{yellow}›%f '

#homebrew
export PATH="/opt/homebrew/bin:$PATH"


# node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

export PATH="$(npm bin -g):$PATH"

#config nvim
export EDITOR=nvim
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

#Aliases

#Vim
alias gvc="cd ~/.config/nvim"
alias vim=nvim
alias vi=nvim
alias v=nvim
alias nv=nvim

#Git
alias gs="git status"
alias gss="git status --short"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"
alias gb="git branch"
alias gd="git diff"

#zsh
alias reload="source ~/.zshrc"
alias zsh="nvim ~/.zshrc"

#misc
alias lah="ls -lah"
alias gotop="clear && gotop"
alias cls=clear
alias dot="cd ~/.dotfiles"
alias fastfetch="clear && fastfetch"
alias matrix="cmatrix"

# Zsh Autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Zsh Syntax Highlighting (must be last)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# bun completions
[ -s "/Users/oskalbarczyk/.bun/_bun" ] && source "/Users/oskalbarczyk/.bun/_bun"

# opencode
export PATH=/Users/oskalbarczyk/.opencode/bin:$PATH
