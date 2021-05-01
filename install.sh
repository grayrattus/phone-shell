mkdir ~/.config/nvim
ln -n dnvim.vim ~/.config/nvim/dnvim.vim
zsh generate-emojis-file.sh
cp .profile ~/.dnvim-profile
echo "source ~/.dnvim-profile" >> ~/.zshrc
