#!/bin/bash
# Save as tmux-session-switch.sh

# List sessions with number, then prompt user for choice
tmux list-sessions -F '#S' | nl -v 1
read -p "Enter session number to switch: " idx
session=$(tmux list-sessions -F '#S' | sed -n "${idx}p")
if [ -n "$session" ]; then
    tmux switch-client -t "$session"
else
    echo "No such session"
fi

