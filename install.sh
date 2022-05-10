#!/bin/dash


# list of dependencies
# unzip, curl, git, fd-find(fd), npm, yarn

PACKMANAGER=''
PACK=''
while true; do
	printf "What package manager do you use ? \n1. apt \n2. pacman \n3. homebrew"
	read -p "Type your choice [1/2/3]: " choice
	case $choice in
		1) PACKMANAGER="apt install"
			break;;
		2) PACKMANAGER="pacman -S"
			break;;
		3) PACKMANAGER="brew install"
			break;;
		0) exit
			break;;
		*) echo "invalid choice!"
	esac
done
# installing dependencies
# tslib
sudo npm i -g tslib
# rg



