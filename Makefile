EMACS ?= emacs

.PHONY: all
all:
	@printf "* Checking Emacs Version...\n"
	@$(EMACS) --version | head -1
	@printf "* Compiling...\n"
	$(EMACS) -Q --batch -f batch-byte-compile gitignore-templates.el

xuchunyang:
	@for cmd in emacs emacs-24.4.2 emacs-24.5.2 emacs-25.1.1 emacs-25.3.1; do \
	    make EMACS=$$cmd ;\
	done
