#!/bin/bash

# set some colors
CNT="[\e[1;36mNOTE\e[0m]"
COK="[\e[1;32mOK\e[0m]"
CER="[\e[1;31mERROR\e[0m]"
CAT="[\e[1;37mATTENTION\e[0m]"
CWR="[\e[1;35mWARNING\e[0m]"

# Define variables
BIN=$(cd $(dirname $0); pwd)
PARENT=$(cd $(dirname $0)/../; pwd)
INSTLOG="$BIN/install.log"

######

# function that would show a progress bar to the user
show_progress() {
    while ps | grep $1 &> /dev/null ; do
        echo -n "."
        sleep 2
    done
    echo -en "Done!\n"
    sleep 2
}

wait_yn(){
    YN="xxx"
    while [ $YN != 'y' ] && [ $YN != 'n' ] ; do
        read -p "$1 [y/n]" YN
    done
}
######

clear

# give the user an option to exit out
wait_yn $'[\e[1;33mACTION\e[0m] - Would you like to start with the install?'
if [[ $YN = y ]] ; then
    echo -e "$CNT - Setup starting..."
else
    echo -e "$CNT - This script will now exit, no changes were made to your system."
    exit
fi

echo -en "$CNT - Now installing CLI for Xcode ."
xcode-select --install
show_progress $!

# Install rosetta
wait_yn $'[\e[1;33mACTION\e[0m] - Would you like to install rosetta?'
if [[ $YN = y ]] ; then
    sudo softwareupdate --install-rosetta --agree-to-licensesudo softwareupdate --install-rosetta --agree-to-license
fi

if ! type brew &> /dev/null ; then
    echo -en "$CNT - Now installing Homebrew."
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    show_progress $!
else
    echo "Since Homebrew is already installed, skip this phase and proceed."
fi

# brew path setting
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile

# Install app from Brewfile
wait_yn $'[\e[1;33mACTION\e[0m] - Would you like to install app from Brewfile'
if [[ $YN = y ]] ; then
    brew bundle install --file $BIN/Brewfile
fi

# Install custom app
wait_yn $'[\e[1;33mACTION\e[0m] - Would you like to install custom app'
if [[ $YN = y ]] ; then
    git clone http://github.com/possatti/pokemonsay
    cd pokemonsay
    ./install.sh
    echo export \""PATH="\$PATH:/Users/$USER/bin\" >> ~/.zshrc

# Copy Config Files
wait_yn $'[\e[1;33mACTION\e[0m] - Would you like to copy config files?'
if [[ $YN = y ]] ; then
    echo -e "$CNT - Copying config files..."

    # copy the configs directory
    cp -rT $PARENT/. ~/ &>> $INSTLOG
fi

yabai --start-service
skhd --start-service

ln -s ~/Documents ~/Documents-ln
ln -s ~/Downloads ~/Downloads-ln
