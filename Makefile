
.PHONY: clean install vim tmux nvim bash git

install: vim tmux nvim bash git

vim: ./vim/vimrc
	cp $< ~/.vim/

tmux: ./tmux/tmux.conf
	cp $< ~/.tmux.conf

nvim: ./nvim/init.vim
	cp $< ~/.config/nvim/init.vim

git: ./git/ignore
	cp $< ~/.config/git/ignore
	git config --global core.excludesfile ~/.config/git/ignore

bash: ./bash/bash_aliases
	cp $< ~/.bash_aliases
