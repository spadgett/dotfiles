bindkey -v

# http://zsh.sourceforge.net/Doc/Release/Options.html
setopt append_history
setopt hist_ignore_all_dups
setopt hist_ignore_space

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

export EDITOR=nvim
export GOPATH=~/go
export LANG=en_US.UTF-8
export PAGER=less
export VISUAL=nvim

autoload -Uz compinit
compinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

alias ls='ls -G'
alias gbda='git branch --no-color --merged | command grep -vE "^(\*|\s*(master|develop|dev)\s*$)" | command xargs -n 1 git branch -d'

# npm install --global pure-prompt
# https://github.com/sindresorhus/pure
autoload -U promptinit; promptinit
prompt pure
