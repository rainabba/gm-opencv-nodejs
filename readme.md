# gm-opencv-nodejs

This project is to create/maintain [rainabba/gm-opencv-nodejs](https://hub.docker.com/r/rainabba/gm-opencv-nodejs/) on Dockerhub.

The generated Docker image provides an [Ubuntu 16/Xenial](http://releases.ubuntu.com/16.04/) environment with [NodeJS 9.11.2](https://nodejs.org/en/download/current/) so an app can be built and hosted with the ability to use [OpenCV 3.4.1](https://github.com/justadudewhohacks/opencv4nodejs) and [graphicsmagick](http://www.graphicsmagick.org/index.html) manipulations, with the expectation of real-time performance for most reasonable tasks.


## To run an interactive container right now!
```bash
docker run --user linuxbrew -p 5000:5000 -p 0.0.0.0:9229:9229 -e DISPLAY=unix$DISPLAY -v /var/run/docker.sock:/var/run/docker.sock -v /tmp/.X11-unix:/tmp/.X11-unix --name `whoami`/gm-opencv-nodejs:latest -it rainabba/gm-opencv-nodejs:1.0.0 /bin/bash; 
```

## How I use this image

I use this image to as a base for my nodejs dev/runtime containers which need image/video processing. By mounting the working folder, I can run the container, then run my node app inside, while using editors outside the container (working directory) AND 9229 (nodejs debugging) is passed through as well. This is an example of how I'd debug (see the run-script that follows).

```Dockerfile
FROM rainabba/gm-opencv-nodejs:latest 

LABEL maintainer="Michael Richardson <rainabba@gmail.com>"

USER root 
RUN apt-get update -y \ 
&& apt-get upgrade -y \ 
&& update-ca-certificates --fresh \ 
&& apt-cache policy ca-certificates \
&& npm install -g nodemon; 

USER linuxbrew 
ENV APP_PORT 5000
EXPOSE $(APP_PORT) 9229 
ARG WORKDIR=/usr/src 
WORKDIR $WORKDIR 

#Add your working folder to /usr/src
ADD . $WORKDIR

CMD [ "nodemon --inspect=0.0.0.0:9229 src/" ]
```

This allows me to sit in a bash shell, run my nodejs app, check the filesystem, etc.. while using tools on my desktop to change code, more view on files, etc.. In theory, you should be able to install/run xclient apps (typically requires GTK also from what I've seen) and then an XClient on the host (Windows 10 with WSL/Ubuntu in my case)
```bash
#!/bin/sh
set -x #echo on;
docker run  -p 5000:5000 -p 0.0.0.0:9229:9229 \
-e DISPLAY=unix$DISPLAY \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /home/rainabba/.ssh:/root/.ssh \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-v ${PWD}:/usr/src --name $CONTAINER_NAME -it $IMAGE_NAME /bin/bash
```


## To run a container

`cd ~/gm-opencv-nodejs && sh ./run-image.sh`

by virtue of being a published project, 
the default WILL try to run the official image which won't exist locally and so it will be pulled. 
If you build using the script below, this will run YOUR local image.


## To build your own image

`mkdir ~/gm-opencv-nodejs && cd ~/gm-opencv-nodejs && sh ./build-image.sh`


## TL;DR

I hope the pros will find this image was built using the most significant, best-practices for Docker as of 2018-08-17, but if you want to contribute with PR's or just drop me an issue and give me suggestions, I'm all ears.
