#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#PS1='[\u@\h \W]\$ '

#export XFCE_WALLPAPER=$(grep -m 1 "last-image" ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-desktop.xml | awk -F'"' '{print $6}' | xargs -L 1)

alias grep='grep --color=auto'
alias ls='lsd'
alias python="python3"
alias pip="pip3"
alias clear="paclear -c yellow -s 3"

cheatsh() { curl "http://cheat.sh/$1"; }
eval "$(starship init bash)"

# Write from "Caveats" of 'brew (re)install python3'.
# Python3
export PATH="$PATH:/usr/local/bin/python3"
# installed by pip3
export PATH="$PATH:/usr/local/opt/python@3.12/libexec/bin"

neowofetch --gap -30 --ascii "$(fortune -s | pokemonsay -w 30)"
