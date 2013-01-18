# Activate/deactivate config files as needed

.Phony: help install pydist status vim_pathogen
help: 
	@echo "Manage config files"
	@echo "  help - this message"
	@echo "  install - create symlinks for common files"
	@echo "  pydist - toggle local user install of python packages"
	@echo "  status	- report on state of installation"

# all the common rc files
DOT_FILES= \
	bash_profile \
	bashrc \
	editrc \
	gitconfig \
	gitignore \
	gitk \
	gvimrc \
	hgignore \
	hgignore_global \
	hgrc \
	inputrc \
	screenrc \
	tmux.conf \
	vimrc \
	xinitrc \

# other targets that install things similar to dotfiles
MISC_TARGETS= \
	vim_pathogen

# my scripts
BIN_FILES = \
	git-diff-driver \
	myscreen \
	rprompt \
	sourceAuthSocket \
	ack \


# normal install consists of both scripts and rc files
install: bin_files dot_files $(MISC_TARGETS)
	@echo "# REMEMBER TO EXECUTE THE ABOVE LINES"

ack:
	curl http://betterthangrep.com/ack-standalone > $@
	chmod 0755 $@

vimack: ack
	curl -L https://github.com/mileszs/ack.vim/archive/master.tar.gz > /tmp/ackvim.tgz
	tar xzf /tmp/ackvim.tgz -C /tmp/
	mkdir -p $(HOME)/.vim/{doc,plugin,after}
	for f in /tmp/ack.vim-master/doc/* ; do \
	    cp -i $$f $(HOME)/.vim/doc/ ; \
	done
	vim --cmd "helptags $(HOME)/.vim/doc/" --cmd quit
	for f in /tmp/ack.vim-master/plugin/* ; do \
	    cp -i $$f $(HOME)/.vim/plugin/ ; \
	done
	rm -rf /tmp/ackvim.tgz /tmp/ack.vim-master

vim_pathogen:
	# see commit message for pathogen.vim for version details
	@if test -h ~/.vim/autoload/pathogen.vim ; then \
	    echo "#~/.vim/autoload/pathogen.vim  is already symlinked"; \
	elif test -f ~/.vim/autoload/pathogen.vim ; then \
	    echo "#~/.vim/autoload/pathogen.vim exists already"; \
	else \
	    echo "ln -s $(PWD)/pathogen.vim" ~/.vim/autoload/pathogen.vim; \
	fi; \

lesspipe.sh: 
	curl -O http://www-zeuthen.desy.de/~friebel/unix/less/lesspipe.tar.gz

# expected resources
EXPECTED_FILES = \
	lesspipe.sh \
	ack \

dot_files: $(DOT_FILES)
	@for f in $?; do \
	    if test -h ~/.$$f ; then \
		echo "#$$f is already symlinked"; \
	    elif test -f ~/.$$f ; then \
		echo "#$$f exists already"; \
	    else \
		echo "ln -s $(PWD)/$$f" ~/.$$f; \
	    fi; \
	done 

bin_files: $(BIN_FILES)
	@for f in $?; do \
	    if test -h ~/bin/$$f ; then \
		echo "#$$f is already symlinked"; \
	    elif test -f ~/bin/$$f ; then \
		echo "#$$f exists already"; \
	    else \
		echo "ln -s $(PWD)/$$f" ~/bin/$$f; \
	    fi; \
	done 

# toggle ability to install into ~/Library
pydist:
	@if test -h ~/.pydistutils.cfg ; then \
	    unlink ~/.pydistutils.cfg ; \
	    echo "local package install disabled" ; \
	elif test -f $(PWD)/pydistutils.cfg ; then \
	    ln -s $(PWD)/pydistutils.cfg ~/.pydistutils.cfg; \
	    echo "local package install enabled" ; \
	else \
	    echo "local package install NOT enabled" ; \
	    echo "you may be in the wrong directory" ; \
	    exit 1 ; \
	fi

# report on exceptions to full install
status:
	@for f in $(DOT_FILES); do \
	    if ! test -h ~/.$$f ; then \
		echo "WARNING: not using ./.$$f"; \
	    fi; \
	done 
	@for f in $(BIN_FILES); do \
	    if ! test -h ~/bin/$$f ; then \
		echo "WARNING: ~/bin/$$f is NOT active"; \
	    fi; \
	done 
	@for f in $(EXPECTED_FILES); do \
	    if ! type -p $$f &>/dev/null ; then \
		echo "WARNING: $$f not installed on system"; \
	    fi; \
	done
	@if test -h ~/.pydistutils.cfg ; then \
	    echo "WARNING: local package install enabled" ; \
	fi
	@if ! git status | grep -q '^nothing to commit' ; then \
	    echo "WARNING: uncommited changes" ; \
	fi
