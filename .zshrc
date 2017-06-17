# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

setopt HIST_IGNORE_ALL_DUPS

export EDITOR=vim
export LANG=en_US.UTF-8
export PAGER=less

set -o vi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --glob "!{.git,dist}/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
