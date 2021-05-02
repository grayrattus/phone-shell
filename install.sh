mkdir ~/.config/nvim
cp dnvim.vim ~/.config/nvim/dnvim.vim
zsh generate-emojis-file.sh
cp .profile ~/.dnvim-profile
if ! grep -q dnvim-profile "~/.zshrc"; then
	echo "source ~/.dnvim-profile" >> ~/.zshrc
fi
