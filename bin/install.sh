#!/bin/bash

CURRENT=$(cd $(dirname $0)/../; pwd)

echo "Installing Xcode..."
xcode-select --install

# Install rosetta
sudo softwareupdate --install-rosetta --agree-to-licensesudo softwareupdate --install-rosetta --agree-to-license

if ! type brew &> /dev/null ; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Since Homebrew is already installed, skip this phase and proceed."
fi

echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"
brew bundle install --file $CURRENT/Brewfile

git clone http://github.com/possatti/pokemonsay
cd pokemonsay
./install.sh

yabai --start-service
skhd --start-service

ln -s ~/Documents ~/Documents-ln
ln -s ~/Downloads ~/Downloads-ln
