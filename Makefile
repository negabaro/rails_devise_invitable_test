ENV_MODE="dev"
SERVICE="devise_invitable"
CONTAINER_NAME=${ENV_MODE}-${SERVICE}
IMG_NAME="rails"
RAILS_CONTAINER_ID=`docker ps | grep $(SERVICE) | awk '{print $$1}'`

define DOCKER_RUN
docker run \
	--rm --name $(CONTAINER_NAME) \
  -v `pwd`:/app:cached \
  -p 3003:3000 	$(IMG_NAME)/$(CONTAINER_NAME)
endef
export DOCKER_RUN

define DOCKER_BUILD
docker build -t ${IMG_NAME}/${CONTAINER_NAME} --file Dockerfile .
endef

define DOCKER_RM_IF_CONTAINER_IS_ALIVE
if [ `docker ps -q -f name=${CONTAINER_NAME}` ]; then docker rm -f ${CONTAINER_NAME}; fi
endef

# rails dockerイメージをbuildする
build:
	$(DOCKER_RM_IF_CONTAINER_IS_ALIVE)
	$(DOCKER_BUILD)

# rails dockerイメージをbuild & runする
build-run:
	$(DOCKER_RM_IF_CONTAINER_IS_ALIVE)
	$(DOCKER_BUILD)
	$(DOCKER_RUN)

run:
	$(DOCKER_RM_IF_CONTAINER_IS_ALIVE)
	$(DOCKER_RUN)

bash:
	docker exec -it $(RAILS_CONTAINER_ID) bash