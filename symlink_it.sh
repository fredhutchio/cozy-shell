#!/bin/sh

relink() {
  rm $1
  ln -sn $2 $1
}

DOTFILES=$(pwd)

cd

relink .zsh $DOTFILES/zsh
relink .zshrc $DOTFILES/zshrc
relink .tmux.conf $DOTFILES/tmux.conf

# Perhaps you would like to link your .Rprofile, .gitconfig, .ssh/config,
# or your editor configuration files?

