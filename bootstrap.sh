sudo apt update
mkdir ~/.setup

fun(){
	echo "Installing the fun stuff...."
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
	echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
	sudo add-apt-repository ppa:mamarley/quassel -y
	sudo apt update
	sudo apt install spotify-client quassel youtube-dl ffmpeg htop -y

}

essential(){
	echo "Installing the essentials....."
	sudo apt install git wget python python-pip python-virtualenv chromium-browser tlp -y
	sudo tlp start
}

cloud(){
	cd ~/.setup
	echo "Installing rclone....."

	curl -O http://downloads.rclone.org/rclone-current-linux-amd64.zip
	unzip rclone-current-linux-amd64.zip
	cd rclone-*-linux-amd64
	sudo cp rclone /usr/sbin/
	sudo chown root:root /usr/sbin/rclone
	sudo chmod 755 /usr/sbin/rclone
	rm -rf ~/.setup/rclone*
}

zsh(){
	echo "Configuring zsh...."
	sudo apt install zsh -y
	cd ~/.setup
	git clone https://github.com/zsh-users/antigen
	git clone https://github.com/powerline/fonts
	cd fonts && ./install.sh && cd ..
	cp ~/linux_setup/.zshrc ~/.zshrc
}

dev_tools(){
	echo "Installing Atom......"
	essential
	cd ~/.setup
	wget https://atom.io/download/deb -O atom-amd64.deb
	sudo dpkg -i atom-amd64.deb
	rm atom*
	echo "Installing Node......"
	curl -sL https://deb.nodesource.com/setup | sudo bash -
	sudo apt install nodejs build-essential -y
	sudo ln -s /usr/bin/nodejs /usr/bin/node
}

aliases(){
	echo "alias gs='git status'" >> ~/.zshrc
	echo "alias gaa='git add -A'" >> ~/.zshrc
	echo "alias gcm='git commit -m'" >> ~/.zshrc
	echo "alias gpm='git push origin master'" >> ~/.zshrc
}


all(){
    install_essential
    install_cloud
    install_zsh
    install_fun
}

$@
