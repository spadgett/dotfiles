# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export EDITOR=vim
export LANG=en_US.UTF-8
export PAGER=less

set -o vi
bindkey -M vicmd '?' history-incremental-search-backward
