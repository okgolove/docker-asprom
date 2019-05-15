IMAGE_NAME ?= okgolove/asprom
CIRCLE_TAG ?= dev

.PHONY: all build release

build:
	docker build -t $(IMAGE_NAME):$(CIRCLE_TAG) .

release:
	docker push $(IMAGE_NAME):$(CIRCLE_TAG)

all: build release
	@echo 'Finished ...'
