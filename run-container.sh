#!/bin/bash
set -x #echo on;
CODE_VERSION_PREVIOUS=$(cat package.json | grep versionPrevious | head -1 | awk -F: '{ print $2 }' | sed 's/[\",]//g' | tr -d '[[:space:]]')-dev;
CODE_VERSION=$(cat package.json | grep version | head -1 | awk -F: '{ print $2 }' | sed 's/[\",]//g' | tr -d '[[:space:]]')-dev;
PACKAGE_NAME=$(cat package.json | grep name | head -1 | awk -F: '{ print $2 }' | sed 's/[\",]//g' | tr -d '[[:space:]]') 
CONTAINER_NAME=$PACKAGE_NAME-$CODE_VERSION 
IMAGE_BUILDER=$(cat package.json | grep authorHandle | head -1 | awk -F: '{ print $2 }' | sed 's/[\",]//g' | tr -d '[[:space:]]') 
IMAGE_NAME=$IMAGE_BUILDER/$PACKAGE_NAME:latest
if [ "`docker inspect -f '{{.State.Running}}' $PACKAGE_NAME-$CODE_VERSION`" = "true" ] ; then
	docker stop $PACKAGE_NAME-$CODE_VERSION;
fi
docker rm $CONTAINER_NAME;
docker run --user linuxbrew -p 5000:5000 -p 0.0.0.0:9229:9229 \
-e DISPLAY=unix$DISPLAY \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /tmp/.X11-unix:/tmp/.X11-unix \
--name $CONTAINER_NAME -it $IMAGE_NAME /bin/bash;
