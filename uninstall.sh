#!/bin/bash

olddir=~/rejkadotfiles_old                      # old dotfiles backup directory
files="vim vimrc bashrc tmux.conf gitconfig"     # list of files/folders to symlink in homedir
configs="alacritty"

echo "Uninstalling rejkadotfiles :recycle:"

for file in $files; do
  echo -n "Deleting symlinks to $file in home directory"
  rm -rf ~/.$file
  echo -n "Moving dotfiles from $olddir to ~"
  mv $olddir/$file ~/.$file
done

for config in $configs; do
  echo -n "Deleting symlinks to $config from ~/.config"
  rm -rf ~/.config/$config
  echo "Moving config from $olddir to ~/.config"
  mv $olddir/$config ~/.config/$config
done

echo "Completed!"
