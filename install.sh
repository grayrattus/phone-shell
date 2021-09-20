mkdir ~/.config/vim
cp dvim.vim ~/.config/vim/dvim.vim
zsh generate-emojis-file.sh
chmod +x emoji.sh
phoneTermuxDirectory="/data/data/com.termux/files/usr/bin"

if [ -d "$phoneTermuxDirectory" ]; then
	cp emoji.sh $phoneTermuxDirectory/emoji
else 
	cp emoji.sh /usr/local/bin/emoji
fi
cp .profile ~/.dvim-profile
if ! grep -q dnvim-profile ~/.zshrc; then
	echo "source ~/.dvim-profile" >> ~/.zshrc
fi
