
.PHONY: clean install vim tmux nvim

install: vim tmux nvim

vim: ./vim/vimrc
	cp $< ~/.vim/

tmux: ./tmux/tmux.conf
	cp $< ~/.tmux.conf

nvim: ./nvim/init.vim
	cp $< ~/.config/nvim/init.vim
