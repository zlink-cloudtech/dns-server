IMAGE_NAME ?= zlinkcloudtech/dns-server
IMAGE_VER ?= latest
IMAGE_NAME_AMD64 ?= $(IMAGE_NAME)-amd64:$(IMAGE_VER)
IMAGE_NAME_ARM64 ?= $(IMAGE_NAME)-arm64:$(IMAGE_VER)
BASE_IMAGE_AMD64 ?= alpinelinux/unbound:latest
BASE_IMAGE_ARM64 ?= alpinelinux/unbound:latest-aarch64
COUNTRY ?=
# PUSH_IMAGE ?= YES
PLATFORM_AMD64 = linux/amd64
PLATFORM_ARM64 = linux/arm64

.PHONY: build-amd64 build-arm64 build-all

# Default target: build x64
build-amd64:
	docker build \
		--platform $(PLATFORM_AMD64) \
		--build-arg BASE_IMAGE=$(BASE_IMAGE_AMD64) \
		--build-arg COUNTRY=$(COUNTRY) \
		-t $(IMAGE_NAME_AMD64) .
	@if [ "$(PUSH_IMAGE)" = "YES" ]; then \
		echo "Pushing image..."; \
		docker push $(IMAGE_NAME_AMD64); \
	fi

build-arm64:
	docker build \
		--platform $(PLATFORM_ARM64) \
		--build-arg BASE_IMAGE=$(BASE_IMAGE_ARM64) \
		--build-arg COUNTRY=$(COUNTRY) \
		-t $(IMAGE_NAME_ARM64) .
	@if [ "$(PUSH_IMAGE)" = "YES" ]; then \
		echo "Pushing image..."; \
		docker push $(IMAGE_NAME_ARM64); \
	fi

build-all: build-amd64 build-arm64