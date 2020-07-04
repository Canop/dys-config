
.PHONY: clean install vim tmux nvim bash git broot

install: vim tmux nvim bash git

# vim: ./vim/vimrc
# 	cp $< ~/.vim/

broot: ./broot/git-diff-conf.toml
	cp $< ~/.config/broot/git-diff-conf.toml

tmux: ./tmux/tmux.conf
	cp $< ~/.tmux.conf

nvim: ./nvim/init.vim
	cp $< ~/.config/nvim/init.vim

git: git_ignore git_config

git_ignore: ./git/ignore
	cp $< ~/.config/git/ignore

git_config: ./git/.gitconfig
	cp $< ~/.gitconfig

bash: ./bash/bash_aliases
	cp $< ~/.bash_aliases
