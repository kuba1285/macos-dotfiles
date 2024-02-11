#┌─┐┬─┐┌─┐┌┬┐┌─┐┌┬┐
#├─┘├┬┘│ ││││├─┘ │ 
#┴  ┴└─└─┘┴ ┴┴   ┴ 
PROMPT="%K{white}%F{black}  %n %f%k%K{cyan}%F{white}%f%k%K{cyan}%F{black} ⌖ %~ %f%k%F{cyan}%f"

#┌─┐┬  ┬┌─┐┌─┐
#├─┤│  │├─┤└─┐
#┴ ┴┴─┘┴┴ ┴└─┘
cheatsh() { curl "http://cheat.sh/$1"; }
alias ls='lsd'

#┬  ┬┌─┐┬─┐┬┌─┐┌┐ ┬  ┌─┐
#└┐┌┘├─┤├┬┘│├─┤├┴┐│  ├┤ 
# └┘ ┴ ┴┴└─┴┴ ┴└─┘┴─┘└─┘
export PATH="$PATH:/Users/mymac/bin"
neowofetch --gap -30 --ascii "$(fortune | pokemonsay -w 30)"
