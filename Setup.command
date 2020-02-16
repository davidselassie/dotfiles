#!/bin/bash

set -eEox

# Create a brew group to allow multi-user homebrew.
if ! dseditgroup -o read brew &> /dev/null; then
    sudo dseditgroup -o create brew
fi

# Ensure I'm in that group.
if [[ $(groups) != *brew* ]]; then
    sudo dseditgroup -o edit -a "$USER" -t user brew
fi

# Install homebrew.
# brew fails if in an iCloud directory. Temporarily cd to something real.
if [[ -z "$(command -v brew)" ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# /usr/local itself is owned by wheel, but everything within is owned by homebrew.
chgrp -R brew "$(brew --prefix)"/*
chmod -R g+w "$(brew --prefix)"/*

# Install fish.
brew install fish

# Path to fish needs to be in the "standard shell" listing.
# grep -v and -q seem to not work together?
if ! grep -qxF /usr/local/bin/fish /etc/shells; then
    echo /usr/local/bin/fish | sudo tee -a /etc/shells
fi

# Change my shell to fish.
if [[ $(dscl . -read "/Users/$USER" UserShell) != 'UserShell: /usr/local/bin/fish' ]]; then
    chsh -s /usr/local/bin/fish
fi

# Install command line utils.
brew install \
  dos2unix \
  fex \
  hub \
  jq \
  miller \
  moreutils \
  pv \
  ripgrep \
  watch \
  
# Install GUI apps.
brew cask install \
  1password \
  bbedit \
  hammerspoon \
  iterm2 \
  karabiner-elements \
  viscosity \

# Symlink in configs using stow.
brew install stow
# Where to unstow things from. This script should be at the top level of the stow directories.
export STOW_DIR="$(dirname $0)"

# Things that require each individual file to be symlinked. This is so we can have per-machine stuff within the directories.
stow -v -t "$HOME" --no-folding --ignore='\.DS_Store' \
  fish \
  local \
  ssh \
  
# Things that we can simlink the whole dir.
stow -v -t "$HOME" --ignore='\.DS_Store' \
  git \
  hammerspoon \
  karabiner \
  services \

# This one is strange. iTerm will ignore any symlinks at this file and immediately overwrite it with a default one. So copy the config, but the config itself says save preferences at another location, the copy source.
cp "$STOW_DIR/com.googlecode.iterm2.plist" "$HOME/Library/Preferences"

# Setup krypton for code signing.
brew install kryptco/tap/kr
kr restart
sleep 1
if ! kr me > /dev/null; then
    kr pair
fi
if [[ $(git config --global --get gpg.program) != '/usr/local/bin/krgpg' ]]; then
    kr codesign
    # kr uses tabs...
    expand -t4 "$HOME/.gitconfig" | sponge "$HOME/.gitconfig"
fi

# Open all the things!
open '/Applications/1Password 7.app'
open /Applications/Hammerspoon.app
open /Applications/iTerm.app
open /Applications/Karabiner-Elements.app
open /Applications/Viscosity.app
