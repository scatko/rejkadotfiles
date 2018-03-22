#!/bin/bash

olddir=~/rejkadotfiles_old     # old dotfiles backup directory
files="vim vimrc gitconfig"    # list of files/folders to symlink in homedir

echo "Uninstalling rejkadotfiles :recycle:"

for file in $files; do
  echo -n "Deleting symlinks to $file in home directory"
  rm -rf ~/.$file
  echo -n "Moving dotfiles from $olddir to ~"
  mv $olddir/$file ~/.$file
done

echo "Completed!"
