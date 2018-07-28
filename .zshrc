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

export GOPATH=~/go
export LANG=en_US.UTF-8
export PAGER=less
export VISUAL=nvim

path=(
  $GOPATH/src/github.com/openshift/origin/_output/local/bin/darwin/amd64
  $GOPATH/bin
  $path
)

autoload -Uz compinit
compinit

set -o vi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --glob "!{.git,dist,node_modules,bower_components}/*"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

alias ls='ls -G'

# Git aliases borrowed from oh my zsh
# https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/git/git.plugin.zsh
alias gb='git branch'
alias gbda='git branch --no-color --merged | command grep -vE "^(\*|\s*(master|develop|dev)\s*$)" | command xargs -n 1 git branch -d'
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
