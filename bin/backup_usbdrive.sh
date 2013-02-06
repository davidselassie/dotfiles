#!/bin/bash

DEST="/Volumes/Backup/Backup"
LIST="$HOME/Development $HOME/Documents $HOME/Desktop $HOME/Dropbox  $HOME/.dotfiles $HOME/Music $HOME/Pictures"

rsync -av --delete $LIST $DEST
