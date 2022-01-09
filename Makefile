#
# Authors:
#  - Abhimanyu Saharan <desk.abhimanyu@gmail.com>
#  - Anuj Saharan <add you email here>
#

REGISTRY_HOST=ghcr.io
OWNER=codalizer
NAME=$(shell basename -s .git `git config --get remote.origin.url`)
IMAGE=$(REGISTRY_HOST)/$(OWNER)/$(NAME)

LATEST_TAG=$(IMAGE):latest
BRANCH_TAG=$(IMAGE):$(shell ./version.sh)

SHELL=/bin/bash

DOCKER_BUILD_CONTEXT=.
DOCKER_FILE_PATH=Dockerfile
DOCKER_BUILD_ARGS=--compress

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: docker-build ## Builds a new version and tags it

docker-build:
	@docker build $(DOCKER_BUILD_ARGS) -t $(LATEST_TAG) $(DOCKER_BUILD_CONTEXT) -f $(DOCKER_FILE_PATH)

push: pre-push do-push ## Push the image to the registry

pre-push:
	@docker tag $(LATEST_TAG) $(BRANCH_TAG)

do-push:
	@docker push $(LATEST_TAG)
	@docker push $(BRANCH_TAG)

image-name: ## Returns only the name of the image (without version)
	@echo $(IMAGE):$(PARTIAL-TAG)

image-bversion: ## Returns the branch tag for the image
	@echo $(BRANCH_TAG)

image-lversion: ## Returns the latest tag for the image
	@echo $(LATEST_TAG)