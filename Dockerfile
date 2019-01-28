FROM justadudewhohacks/opencv-nodejs:node9-opencv3.4.1-contrib

LABEL maintainer="Michael Richardson <rainabba@gmail.com>"
LABEL repository="https://github.com/rainabba/gm-opencv-nodejs.git"

ENV DEBIAN_FRONTEND=noninteractive \
	NODE_PATH=/usr/lib/node_modules \
	HOMEBREW_NO_ENV_FILTERING=1 \
	PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
	LD_LIBRARY_PATH=/home/linuxbrew/.linuxbrew/lib \
	LANG="en_US.UTF-8" \
	LC_ALL="en_US.UTF-8" \
	LC_CTYPE=en_US.UTF-8 \
	LANGUAGE="en_US:en"

ARG WORKDIR=/
WORKDIR ${WORKDIR}
COPY ./linuxbrew-graphics-magick.sh /

RUN echo en_US UTF-8 >> /etc/locale.gen \
	#&& apt-get update \
	#&& apt-get upgrade -y \
	&& apt-get install locales \
	&& local-gen \ 
	&& update-ca-certificates --fresh \
	&& apt-cache policy ca-certificates \
	&& apt-get install -y sudo vim pkg-config build-essential wget libc6 curl file git ruby \
	&& find /var/cache/apt/archives /var/lib/apt/lists -not -name lock -type f -delete

RUN useradd -m linuxbrew \
	&& cd /home/linuxbrew \
	&& git clone https://github.com/Homebrew/linuxbrew.git ./.linuxbrew/ \
	&& chown -R linuxbrew:root /home/linuxbrew \
	&& chmod 770 /linuxbrew-graphics-magick.sh \
	&& chown -R linuxbrew:root /linuxbrew-graphics-magick.sh \
	&& sudo ln -s /home/linuxbrew/.linuxbrew/bin/gm /usr/local/bin/gm
	
#USER linuxbrew
#RUN sh /linuxbrew-graphics-magick.sh

CMD ["/bin/bash"]