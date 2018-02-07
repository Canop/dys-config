
.PHONY: clean install vim tmux nvim bash

install: vim tmux nvim bash

vim: ./vim/vimrc
	cp $< ~/.vim/

tmux: ./tmux/tmux.conf
	cp $< ~/.tmux.conf

nvim: ./nvim/init.vim
	cp $< ~/.config/nvim/init.vim

bash: ./bash/bash_aliases
	cp $< ~/.bash_aliases
