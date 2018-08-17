#!/bin/sh
CODE_VERSION=$(cat package.json | grep version | head -1 | awk -F: '{ print $2 }' | sed 's/[\",]//g' | tr -d '[[:space:]]') 
PACKAGE_NAME=$(cat package.json | grep name | head -1 | awk -F: '{ print $2 }' | sed 's/[\",]//g' | tr -d '[[:space:]]') 
IMAGE_BUILDER=$(cat package.json | grep authorHandle | head -1 | awk -F: '{ print $2 }' | sed 's/[\",]//g' | tr -d '[[:space:]]') 
IMAGE_NAME=$IMAGE_BUILDER/$PACKAGE_NAME:$CODE_VERSION  
IMAGE_NAME_LATEST=$IMAGE_BUILDER/$PACKAGE_NAME:latest 
printf "\nBuilding: $IMAGE_NAME\n" 
docker build --no-cache -t $IMAGE_NAME -t $IMAGE_NAME_LATEST .