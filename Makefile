
.PHONY: clean install vim

install: vim

vim: ./vim/vimrc
	cp $< ~/.vim/
