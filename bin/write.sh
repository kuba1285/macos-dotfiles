#!/bin/bash

cat << EOF >> ~/.zshrc
export PATH="\$PATH:/Users/$USER/bin"

bash /Users/$USER/bin/changeWallpaper.sh
neofetch
TMOUT=900
TRAPALRM() {
MODELS=(\$(ls -d /Users/$USER/bin/models/*))
SEC=\`date +%S\`
I=\$((SEC%\$(echo \${#MODELS[@]})+1))
3d-ascii-viewer -z 160 \${MODELS[\$I]}
}
EOF

# yabai sudoers setting
echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai
