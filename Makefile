####################
## Parent Makefile
####################

.DEFAULT_GOAL   	:= help
SHELL           	:= /bin/bash
MAKEFLAGS       	+= --no-print-directory
PARENT_MKFILE_DIR	:= $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
SOPS_KEY 	  		:= $(PARENT_MKFILE_DIR)/secrets/files/sops/sops-age-key.txt
DEC_KEY 	  		:= $(shell cat $(SOPS_KEY))
ENC_KEY	  	  		:= $(shell age-keygen -y $(SOPS_KEY))

define print_title
	@echo "===================================="
	@echo "$1"
	@echo "===================================="
endef

.PHONY: help
help: ## Makefile Help Page
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[\/\%a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-21s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST) 2>/dev/null

.PHONY: guard-%
guard-%:
	@if [[ "${${*}}" == "" ]]; then echo "Environment variable $* not set"; exit 1; fi
