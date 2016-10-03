
.PHONY: clean install vim tmux

install: vim tmux

vim: ./vim/vimrc
	cp $< ~/.vim/

tmux: ./tmux/tmux.conf
	cp $< ~/.tmux.conf
