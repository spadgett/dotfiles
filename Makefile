stow_dirs = $(wildcard */)

.PHONY: stow
stow:
	stow --target $(HOME) --verbose $(stow_dirs)

.PHONY: dry-run
dry-run:
	stow --no --target $(HOME) --verbose $(stow_dirs)

.PHONY: restow
restow:
	stow --target $(HOME) --verbose --restow $(stow_dirs)

.PHONY: delete
delete:
	stow --target $(HOME) --verbose --delete $(stow_dirs)

.PHONY: plug-update
plug-update:
	nvim +PlugUpdate +qall

.PHONY: plug-clean
plug-clean:
	nvim +PlugClean! +qall
