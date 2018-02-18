# Options
# http://zsh.sourceforge.net/Doc/Release/Options.html
setopt append_history
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt pushd_ignore_dups
setopt pushdminus
setopt share_history

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

export LANG=en_US.UTF-8
export PAGER=less
export VISUAL=nvim

autoload -Uz compinit
compinit

set -o vi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --glob "!{.git,dist}/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# FZF Colors (Molokai)
# https://github.com/junegunn/fzf/wiki/Color-schemes
export FZF_DEFAULT_OPTS='
  --color fg:252,bg:234,hl:67,fg+:252,bg+:235,hl+:81
  --color info:144,prompt:161,spinner:135,pointer:135,marker:118
'

# Make working directory the title
function precmd () {
  window_title="\033]0;${PWD##*/}\007"
  echo -ne "$window_title"
}

alias ls='ls -G'

# Git aliases borrowed from oh my zsh
# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/git/git.plugin.zsh
alias gc!='git commit -v --amend'
alias gc='git commit -v'
alias gca!='git commit -v -a --amend'
alias gca='git commit -v -a'
alias gcb='git checkout -b'
alias gcm='git checkout master'
alias gco='git checkout'
alias gd='git diff'
alias gl='git pull'
alias glum='git pull upstream master'
alias gp='git push'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip-- [skip ci]"'

# npm install --global pure-prompt
# https://github.com/sindresorhus/pure
autoload -U promptinit; promptinit
prompt pure
