#┌─┐┬─┐┌─┐┌┬┐┌─┐┌┬┐
#├─┘├┬┘│ ││││├─┘ │ 
#┴  ┴└─└─┘┴ ┴┴   ┴ 
eval "$(starship init zsh)"

#┌─┐┬  ┬┌─┐┌─┐
#├─┤│  │├─┤└─┐
#┴ ┴┴─┘┴┴ ┴└─┘
cheatsh() { curl "http://cheat.sh/$1"; }
alias ls='lsd'

#┬  ┬┌─┐┬─┐┬┌─┐┌┐ ┬  ┌─┐
#└┐┌┘├─┤├┬┘│├─┤├┴┐│  ├┤ 
# └┘ ┴ ┴┴└─┴┴ ┴└─┘┴─┘└─┘
export PATH="$PATH:/Users/mymac/bin"
neowofetch --gap -30 --ascii "$(fortune -s | pokemonsay -w 30)"
