#!/bin/bash 
set -x
echo on; 
CODE_VERSION=$(cat package.json | grep version | head -1 | awk -F: '{ print $2 }' | sed 's/[\",]//g' | tr -d '[[:space:]]') 
PACKAGE_NAME=$(cat package.json | grep name | head -1 | awk -F: '{ print $2 }' | sed 's/[\",]//g' | tr -d '[[:space:]]') 
IMAGE_BUILDER=$(cat package.json | grep authorHandle | head -1 | awk -F: '{ print $2 }' | sed 's/[\",]//g' | tr -d '[[:space:]]') 
docker push $IMAGE_BUILDER/$PACKAGE_NAME:$CODE_VERSION 
docker push $IMAGE_BUILDER/$PACKAGE_NAME:latest 
