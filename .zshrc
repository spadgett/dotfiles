# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

setopt HIST_IGNORE_ALL_DUPS

export LANG=en_US.UTF-8
export PAGER=less
export VISUAL=nvim

set -o vi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --glob "!{.git,dist}/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Always use pwd as tab title
DISABLE_AUTO_TITLE="true"
function precmd () {
  window_title="\033]0;${PWD##*/}\007"
  echo -ne "$window_title"
}
