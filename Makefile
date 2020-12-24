.PHONY: help
help:
	@awk -F':.*##' '/^[-_a-zA-Z0-9]+:.*##/{printf"%-12s\t%s\n",$$1,$$2}' $(MAKEFILE_LIST) | sort

IMAGE=nesachirou/centos:6

build: ## Build a Docker image
	DOCKER_BUILDKIT=1 docker build -t "$(IMAGE)" --build-arg BUILDKIT_INLINE_CACHE=1 --force-rm --pull .

test: ## Test
	hadolint Dockerfile
	container-structure-test test --image "$(IMAGE)" --config container-structure-test.yml
	docker scan "$(IMAGE)" || true
