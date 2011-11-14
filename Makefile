# Activate/deactivate config files as needed

.Phony: help
help: 
	@echo "Manage config files"
	@echo "  help - this message"
	@echo "  install - create symlinks for common files"

# normal install consists of both scripts and rc files
install: bin_files dot_files

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
	hgrc \
	inputrc \
	screenrc \
	vimrc \
	xinitrc \

# my scripts
BIN_FILES = \
	git-diff-driver \
	myscreen \
	rprompt \
	sourceAuthSocket \

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

