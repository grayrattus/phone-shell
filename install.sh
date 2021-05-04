mkdir ~/.config/nvim
cp dnvim.vim ~/.config/nvim/dnvim.vim
zsh generate-emojis-file.sh
chmod +x emoji.sh
phoneTermuxDirectory="/data/data/com.termux/files/usr/bin"

if [ -d "$phoneTermuxDirectory" ]; then
	cp emoji.sh $phoneTermuxDirectory/emoji
else 
	cp emoji.sh /usr/local/bin/emoji
fi
cp .profile ~/.dnvim-profile
if ! grep -q dnvim-profile ~/.zshrc; then
	echo "source ~/.dnvim-profile" >> ~/.zshrc
fi
