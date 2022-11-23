.DEFAULT_GOAL := help
SHELL         := /bin/bash
MAKEFLAGS     += --no-print-directory
MKFILE_DIR    := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

.PHONY: 
submodule-update: ## Initialize, fetch and checkout any nested submodules
submodule-update: 
	@git submodule update --init --recursive

.PHONY: 
sast-scan: ## SAST scan from https://slscan.io/en/latest/ for the root
sast-scan: 
	@docker run --rm -e "WORKSPACE=$(PWD)" -v $(PWD):/app shiftleft/sast-scan scan --build

####################
## Common targets
####################

.PHONY: help
help: ## Makefile Help Page
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[\/\%a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-21s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST) 2>/dev/null

.PHONY: guard-%
guard-%:
	@if [[ "${${*}}" == "" ]]; then echo "Environment variable $* not set"; exit 1; fi