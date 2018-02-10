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
# Colors (Molokai)
# https://github.com/junegunn/fzf/wiki/Color-schemes
export FZF_DEFAULT_OPTS='
  --color fg:252,bg:234,hl:67,fg+:252,bg+:235,hl+:81
  --color info:144,prompt:161,spinner:135,pointer:135,marker:118
'

# Always use pwd as tab title
DISABLE_AUTO_TITLE="true"
function precmd () {
  window_title="\033]0;${PWD##*/}\007"
  echo -ne "$window_title"
}
