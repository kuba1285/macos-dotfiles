#!/bin/bash

cat << EOF >> ~/.zshrc
export PATH="\$PATH:/Users/$USER/bin"
neofetch
TMOUT=900
TRAPALRM() { tput bold && tput setaf 2 && gcc /Users/$USER/bin/donut.c -o /Users/$USER/bin/donut && /Users/$USER/bin/donut }
EOF
