#!/usr/bin/env bash

# If the script is called with exactly one argument ($# -eq 1),
#  it assigns that argument to the variable selected.
#If no arguments are given,
#  it uses find to list directories from specified paths and pipes the list to fzf -
# (a command-line fuzzy finder) to interactively select a directory.

if [[ $# -eq 1 ]]; then
    selected=$1
    # echo "selected $selected"
else
    selected=$(find ~ "/Volumes/[C] Windows 11/inetpub/wwwroot/" ~/Documents ~/vendavo ~/Repos ~/Repos/Projects ~/.config  ~/Books -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

session_name=$(basename "$selected" | tr . _) 

# echo "session_name $session_name"

if ! tmux has-session -t "$session_name" 2> /dev/null; then
   tmux new-session -s "$session_name" -c "$selected" -d 
fi

tmux switch-client -t "$session_name"
