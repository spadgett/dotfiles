set fish_greeting ""

set --export EDITOR nvim
set --export GOPATH $HOME/go
set --export LANG en_US.UTF-8
set --export PAGER less
set --export VISUAL nvim

set -U fish_user_paths $HOME/bin $GOPATH/bin $fish_user_paths

fish_vi_key_bindings
