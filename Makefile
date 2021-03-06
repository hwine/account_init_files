# Activate/deactivate config files as needed

.Phony: help install pydist status vim_pathogen vim_after
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
	gitignore_global \
	gitk \
	gvimrc \
	hgignore \
	hgignore_global \
	inputrc \
	screenrc \
	tmux.conf \
	tmux.conf.Darwin \
	vimrc \


# other targets that install things similar to dotfiles
MISC_TARGETS= \
	# vim_pathogen \
	# vim_after \


# my scripts
BIN_FILES = \
	clean-docker-for-mac.sh \
	git-diff-driver \
	hg-url \
	install_hg_bash_completion \
	myscreen \
	ppass \
	repo_type \
	rprompt \
	sourceAuthSocket \
	super_clear \
	tmux-daemon-start \
	tmux-start \
	tp-due \
	useAWS \
	useAnaconda \
	useDockerWindowsHost \
	useMozAWS \
	usePipenv \
	vim-post-crash \
	# ack \


# normal install consists of both scripts and rc files
install: bin_files dot_files # $(MISC_TARGETS)
	@echo "# REMEMBER TO EXECUTE THE ABOVE LINES"

ack:
	# stay with 1.x as we don't like loss of -a option
	curl http://beyondgrep.com/ack-1.96-single-file > $@
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

vim_after:
	@if test -h ~/.vim/after ; then \
	    echo "#~/.vim/after  is already symlinked"; \
	elif test -f ~/.vim/after ; then \
	    echo "#~/.vim/after exists already"; \
	else \
	    echo "ln -s $(PWD)/vim-after ~/.vim/after"; \
	fi; \

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
	# lesspipe.sh \
	# ack \

dot_files: $(DOT_FILES)
	@symlink() { echo "pushd $(HOME) &>/dev/null; ln -sf $$relpath/$$1 .$$1; popd &>/dev/null" ; } ; \
	for f in $?; do \
	    : relative path from home to here ; \
	    relpath=$$(eval 'a=$$PWD; a=$${a#$$HOME/}; echo $$a') ; \
	    : echo $$relpath ; \
	    if test -h ~/.$$f ; then \
		echo "#$$f is already symlinked"; \
		: check if correct symlink ; \
		link=$$(eval 'readlink ~/.$$f') ; \
		: echo $$link ; \
		if $$(eval 'test "$$link" = "$${link#$$relpath}"') ; then \
		    echo "#WARNING: existing rogue symlink" ; \
		    symlink $$f ; \
		fi ; \
	    elif test -f ~/.$$f ; then \
		echo "#$$f exists already"; \
	    else \
	    : echo "pushd $(HOME) &>/dev/null; ln -s $$relpath/$$f .$$f; popd &>/dev/null"; \
	        symlink $$f ; \
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
	@echo "No longer supported" ; false
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
