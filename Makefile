.DEFAULT_GOAL := help
SHELL         := /bin/bash
MAKEFLAGS     += --no-print-directory
MKFILE_DIR    := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))

.PHONY:
git-sub-update-all: ## Initialize, fetch and checkout any nested submodules
git-sub-update-all:
	@git submodule update --init --recursive

.PHONY:
git-resetToUpstrem: ## Update Repository to upstream. Parameter: R (Repository root). Example: R=docs/ps-docs make git-resetToUpstrem
git-resetToUpstrem:
	@cd $(MKFILE_DIR)/$(R) && git fetch upstream; git reset --hard upstream/main; git push -f

.PHONY:
sast-scan-all: ## SAST scan from https://slscan.io/en/latest/ for the root
sast-scan-all:
	@docker run --rm -e "WORKSPACE=$(PWD)" -v $(PWD):/app shiftleft/sast-scan scan --build

.PHONY:
run-docker-devops: ## Run image from Dockerfile.devops
run-docker-devops:
	cat src/secrets/files/github/gh_token.txt | docker login ghcr.io --username carlosrodlop --password-stdin
	docker run ghcr.io/carlosrodlop/devops:main

####################
## Common targets
####################

.PHONY: help
help: ## Makefile Help Page
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[\/\%a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-21s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST) 2>/dev/null

.PHONY: guard-%
guard-%:
	@if [[ "${${*}}" == "" ]]; then echo "Environment variable $* not set"; exit 1; fi
