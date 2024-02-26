#!/bin/bash

cat << EOF >> ~/.zshrc
export PATH="\$PATH:/Users/$USER/bin"
neofetch
TMOUT=900
TRAPALRM() { tput bold && tput setaf 2 && gcc /Users/$USER/bin/donut.c -o /Users/$USER/bin/donut && /Users/$USER/bin/donut }
EOF

# yabai sudoers setting
echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai
