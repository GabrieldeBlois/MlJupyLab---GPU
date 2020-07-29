GREEN  := $(shell tput -Txterm setaf 2)
WHITE  := $(shell tput -Txterm setaf 7)
YELLOW := $(shell tput -Txterm setaf 3)
RESET  := $(shell tput -Txterm sgr0)
ARCH   := $(shell uname -m)

BASE_IMAGE_NAME	= mljupylab/baseimage

IMAGE_NAME = ${IMAGE_NAME}

TAG = latest

all: build ##@Build Builds the regular CPU image

.PHONY:start stop clean restart tests stats teardown build build-gpu

stats: ##@other Useful docker stats with formating
	@echo $(PROJECT_NAME)
	docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}\t{{.Container}}"

help: ##@other Show this help.
	@perl -e '$(HELP_FUN)' $(MAKEFILE_LIST)

HELP_FUN = \
	%help; \
	while(<>) { push @{$$help{$$2 // 'options'}}, [$$1, $$3] if /^([a-zA-Z\-]+)\s*:.*\#\#(?:@([a-zA-Z\-]+))?\s(.*)$$/ }; \
	print "usage: make [target]\n\n"; \
	for (sort keys %help) { \
		print "${WHITE}$$_:${RESET}\n"; \
		for (@{$$help{$$_}}) { \
			$$sep = " " x (32 - length $$_->[0]); \
			print "  ${YELLOW}$$_->[0]${RESET}$$sep${GREEN}$$_->[1]${RESET}\n"; \
	}; \
	print "\n"; }

start-d: start

launch: build ##@Start Launches the flexylab server
	docker run -it -p 8888:8888 ${IMAGE_NAME}

build: ##@Environment Build the docker image for Kubernetes Airflow operator
	docker build -t ${BASE_IMAGE_NAME}:${TAG} ./build
	docker build -t ${IMAGE_NAME}:${TAG} .

deploy: build ##@Environment Build and deploy the docker image for Kubernetes Airflow operator
	docker push ${IMAGE_NAME}

