#!/bin/bash

gcc /Users/$USER/bin/cube.c -o /Users/$USER/bin/cube
cat << EOF >> ~/.zshrc
export PATH="\$PATH:/Users/$USER/bin"
bash /Users/$USER/bin/changeWallpaper.sh
neofetch
TMOUT=900
TRAPALRM() { tput bold && tput setaf 3 && cube }
EOF

# yabai sudoers setting
echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai
