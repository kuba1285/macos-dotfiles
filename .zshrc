function command_not_found_handler(){
	tput setaf 1 && figlet -f smslant 127 not found
	return 127
}

source ~/.bashrc
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
