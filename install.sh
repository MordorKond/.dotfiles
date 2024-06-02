#!/bin/zsh

DOTFILES="tmux,nvim,zsh,bin,kitty"

for folder in $(echo $DOTFILES | sed "s/,/ /g")
do 
    echo "stow $folder"
    stow -D $folder
    stow $folder
done




