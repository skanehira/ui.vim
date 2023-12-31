VIM := $$(which vim)
NVIM := $$(which nvim)

.PHONY: test
test:
	@echo ==== test in Vim =====
	@THEMIS_VIM=$(VIM) THEMIS_ARGS="-e -s -u DEFAULTS" themis --runtimepath $$PWD
	@echo ==== test in Neovim =====
	@THEMIS_VIM=$(NVIM) THEMIS_ARGS="-e -s -u NONE" themis --runtimepath $$PWD
