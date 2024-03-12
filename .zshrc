function command_not_found_handler(){
	echo -e "\e[31m	▄▄▌ ▐ ▄▌ ▄▄▄· .▄▄ · ▄▄▄▄▄▄▄▄ .·▄▄▄▄  \n" \
			"	██· █▌▐█▐█ ▀█ ▐█ ▀. •██  ▀▄.▀·██▪ ██ \n" \
			"	██▪▐█▐▐▌▄█▀▀█ ▄▀▀▀█▄ ▐█.▪▐▀▀▪▄▐█· ▐█▌\n" \
			"	▐█▌██▐█▌▐█ ▪▐▌▐█▄▪▐█ ▐█▌·▐█▄▄▌██. ██ \n" \
			"	 ▀▀▀▀ ▀▪ ▀  ▀  ▀▀▀▀  ▀▀▀  ▀▀▀ ▀▀▀▀▀• \n"
	return 127
}

source ~/.bashrc
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
