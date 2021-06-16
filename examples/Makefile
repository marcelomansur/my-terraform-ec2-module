ENV_FILE=.env
SHELL=/bin/bash
EXAMPLE_DIR=examples
MODULE_DIR=$$PWD
TERRAFORM_VERSION=1.0.0
TFPLAN = tfplan

ifneq ($(shell test -e $(ENV_FILE) && echo -n yes),yes)
	ERROR := $(error $(ENV_FILE) file not defined in current directory)
endif

# HELP
# This will output the lp for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

hp: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAT_GOAL := help
#
# Run static validations
#
# Terraform fmt
terraform-fmt: ## Run command 'terraform fmt -check'
	  docker run --rm -v $(MODULE_DIR):/app -w /app hashicorp/terraform:$(TERRAFORM_VERSION) fmt
# Terraform init
terraform-init: ## Run command 'terraform init'
	  docker run --rm -v $(MODULE_DIR):/app -w /app hashicorp/terraform:$(TERRAFORM_VERSION) init
# Terraform validate
terraform-validate: ## Run command 'terraform validate'
	  docker run --rm -v $(MODULE_DIR):/app -w /app --env-file $(ENV_FILE) hashicorp/terraform:$(TERRAFORM_VERSION) validate
#
# Run examples
#
terraform-plan: ## Exec a terraform plan and puts it on a file called tfplan
	  docker run --rm -v $(MODULE_DIR):/app -w /app --env-file $(ENV_FILE) hashicorp/terraform:$(TERRAFORM_VERSION) plan -out $(TFPLAN)

terraform-apply: ## Uses tfplan to apply the changes on AWS.
	  docker run --rm -v $(MODULE_DIR):/app -w /app --env-file $(ENV_FILE) hashicorp/terraform:$(TERRAFORM_VERSION) apply -auto-approve $(TFPLAN)

terraform-destroy: ##Destroy all resources created by the terraform file in this repo.
	  docker run --rm -v $(MODULE_DIR):/app -w /app --env-file $(ENV_FILE) hashicorp/terraform:$(TERRAFORM_VERSION) destroy -auto-approve
#
# Run unit tests
#
unit-tests: terraform-fmt terraform-init terraform-validate ## Run unit tests (terraform fmt and validate)
#
# Commands
#
apply: terraform-plan terraform-apply ## Apply terraform example

destroy: terraform-destroy ## Destroy terraform example