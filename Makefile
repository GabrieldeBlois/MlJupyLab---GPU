BASE_IMAGE_NAME	= mljupylab/baseimage

IMAGE_NAME = mljupylab/lab

TAG = latest

all: build ##@Build Builds the regular CPU image

.PHONY:start stop clean restart stats teardown build

stats: ##@other Useful docker stats with formating
	@echo $(PROJECT_NAME)
	docker stats --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemPerc}}\t{{.Container}}"

start-d: start

start: build ##@Start Launches the flexylab server
	docker run -it -p 8888:8888 ${IMAGE_NAME}

build: ##@Environment Build the docker image for Kubernetes Airflow operator
	docker build -t ${BASE_IMAGE_NAME}:${TAG} ./base_image
	docker build -t ${IMAGE_NAME}:${TAG} .

deploy: build ##@Environment Build and deploy the docker image for Kubernetes Airflow operator
	docker push ${IMAGE_NAME}

