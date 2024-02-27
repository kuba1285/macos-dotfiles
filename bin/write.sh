#!/bin/bash

cat << EOF >> ~/.zshrc
export PATH="\$PATH:/Users/$USER/bin"
neofetch
TMOUT=900
TRAPALRM() { tput bold && tput setaf 2 && gcc /Users/$USER/bin/donut.c -o /Users/$USER/bin/donut && /Users/$USER/bin/donut }
EOF

# yabai sudoers setting
echo "$(whoami) ALL=(root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | cut -d " " -f 1) $(which yabai) --load-sa" | sudo tee /private/etc/sudoers.d/yabai

cat << EOF >> ~/.zshrc
# Generate a new XML property list
XMLLIST="\$(plutil -create xml1 - )"
PLIST="/Users/$USER/Library/Application Support/com.apple.wallpaper/Store/Index.plist"

# Inserts the 'SystemDefault' key into the newly created binary property list
# and retrieves and sets the value from the XML property list. 
# Then overwrite and save to the wallpaper settings file.
plutil -create binary1 - | plutil -insert 'SystemDefault' -xml "\${XMLLIST}" -o "\${PLIST}" -
killall WallpaperAgent

# pywal setting
WAL_IMGS=(\$(ls -d /Users/$USER/Pictures/*))
SEC=\`date +%S\`
I=\$((SEC%\$(echo \${#WAL_IMGS[@]})+1))
osascript -e "
tell application \\"System Events\\"
	tell every desktop
		set picture to \\"\${WAL_IMGS[\$I]}\\"
	end tell
end tell"
wal -qni \${WAL_IMGS[\$I]}
EOF
