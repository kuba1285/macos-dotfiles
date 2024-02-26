echo -e export "PATH=\"\$PATH:/Users/$USER/bin\"\nneofetch" >> ~/.zshrc
echo -e "TMOUT=900\nTRAPALRM() { tput bold && tput setaf 2 && gcc /Users/$USER/bin/donut.c -o /Users/$USER/bin/donut && /Users/$USER/bin/donut }" >> ~/.zshrc
