#!/bin/bash

# About Brewfile
# 1. Command line tools registered in Homebrew are "brew 'app-name'" (installed with the brew install command)
# 2. Command line tools not registered in Homebrew are "tap 'app-name'" (installed with the brew tap command)
# 3. Normal applications are "cask 'app-name'" (those installed using Homebrew Cask)
# 4. Apps installed from AppStore are "mas 'app name' id:XX"
# 'brew cask' can be used if you install Homebrew, but 'mas' requires 'mas-cli' to be installed.
# Brewfile can be generated by command 'brew bundle dump' and overwritten by '--force' option.
#
# To disable SIP, do the following:
# 1. Restart your computer in Recovery mode with pressing Command (⌘) + R or longpressing Power.
# 2. Launch Terminal from the Utilities menu.
# 3. Run the command 'csrutil disable'.
# 4. Restart your computer.
# 5. Restart your computer.

# Define variables
BIN=$(cd $(dirname $0); pwd)
PARENT=$(cd $(dirname $0)/../; pwd)
INSTLOG="$BIN/install.log"
######

# set some colors
set_colors() {
    if [ -t 1 ]; then
        RED=$(tput setaf 1)
        GREEN=$(tput setaf 2)
        YELLOW=$(tput setaf 3)
        CYAN=$(tput setaf 6)
        BOLD=$(tput bold)
        RESET=$(tput sgr0)
    else
        RED=""
        GREEN=""
        YELLOW=""
        CYAN=""
        BOLD=""
        RESET=""
    fi
}

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
set_colors

# give the user an option to exit out
wait_yn "${YELLOW}ACITION${RESET} - Would you like to start with the install?"
if [[ $YN = y ]] ; then
    echo -e "${CYAN}NOTE${RESET} - Setup starting..."
else
    echo -e "${CYAN}NOTE${RESET} - This script will now exit, no changes were made to your system."
    exit
fi

# Install CLI for Xcode
echo -en "${CYAN}NOTE${RESET} - Now installing CLI for Xcode."
xcode-select --install &>> $INSTLOG
show_progress $!
echo -e "${GREEN}OK${RESET} - Installed."

# Install rosetta
wait_yn "${YELLOW}ACITION${RESET} - Would you like to install rosetta?"
if [[ $YN = y ]] ; then
    sudo softwareupdate --install-rosetta --agree-to-licensesudo softwareupdate --install-rosetta --agree-to-license &>> $INSTLOG
    show_progress $!
    echo -e "${GREEN}OK${RESET} - Installed."
fi

# Install homebrew
if ! type brew &> /dev/null ; then
    echo -en "${CYAN}NOTE${RESET} - Now installing Homebrew."
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &>> $INSTLOG
    show_progress $!
    echo -e "${GREEN}OK${RESET} - Installed."
else
    echo -e "${CYAN}NOTE${RESET} - Since Homebrew is already installed, skip this phase and proceed."
fi

# Homebrew path setting
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile

# Install app from Brewfile
wait_yn "${YELLOW}ACITION${RESET} - Would you like to install app from Brewfile?"
if [[ $YN = y ]] ; then
    brew bundle install --file $BIN/Brewfile &>> $INSTLOG
    echo -e "${GREEN}OK${RESET} - Installed."
fi

# Install custom app
wait_yn "${YELLOW}ACITION${RESET} - Would you like to install custom app?"
if [[ $YN = y ]] ; then
    source $BIN/custom.sh
    echo -e "${GREEN}OK${RESET} - Installed."
fi

# Copy Config Files
wait_yn "${YELLOW}ACITION${RESET} - Would you like to copy config files?"
if [[ $YN = y ]] ; then
    echo -e "${CYAN}NOTE${RESET} - Copying config files..."

    # copy the configs directory
    cp -rT $PARENT/. ~/ &>> $INSTLOG
    cp $PARENT/src/* /Users/$USER/bin/
    echo -e "${GREEN}OK${RESET} - Installed."
fi

# A bootplug to match the binary format so that yabai can inject code into the Dock of arm64 binaries.
if [[ $(uname -m) == 'arm64' ]]; then
    sudo nvram boot-args=-arm64e_preview_abi
    echo -en "${GREEN}OK${RESET} - A bootplug to match the binary format so that yabai can inject code into the Dock of arm64 binaries."
fi

# Write settings
source $BIN/parse-plist
source $BIN/write.sh

# Generate miscelenaeous file
brew bundle dump
parse-plist > parse-plist
sudo ln -s /Users/$USER/Documents /Users/$USER/Documents-ln
sudo ln -s /Users/$USER/Downloads /Users/$USER/Downloads-ln
sudo ln -s /Users/$USER/ /Users/$USER/$USER-ln

# Enable services
yabai --start-service
skhd --start-service

# Script is done
echo -e "${CYAN}NOTE${RESET} - Script had completed!"
