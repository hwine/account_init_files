# Activate/deactivate config files as needed

.Phony: help
help: 
	@echo "Manage config files"
	@echo "  help - this message"
	@echo "  install - create symlinks for common files"
	@echo "  pydist - toggle local user install of python packages"
	@echo "  status	- report on state of installation"

# normal install consists of both scripts and rc files
install: bin_files dot_files
	@echo "# REMEMBER TO EXECUTE THE ABOVE LINES"

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

# my scripts
BIN_FILES = \
	git-diff-driver \
	myscreen \
	rprompt \
	sourceAuthSocket \
	ack \


ack:
	curl http://betterthangrep.com/ack-standalone > $@
	chmod 0755 $@

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
	else \
	    ln -s $(PWD)/pydistutils.cfg ~/.pydistutils.cfg; \
	    echo "local package install enabled" ; \
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
