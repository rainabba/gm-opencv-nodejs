FROM justadudewhohacks/opencv-nodejs:node9-opencv3.4.1-contrib

LABEL maintainer="Michael Richardson <rainabba@gmail.com>"
LABEL repository="https://github.com/rainabba/gm-opencv-nodejs.git"

USER root
ENV DEBIAN_FRONTEND=noninteractive \
	NODE_PATH=/usr/lib/node_modules \
	PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
	HOMEBREW_NO_ENV_FILTERING=1
RUN apt-get update \
	&& echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& apt-get install -y --no-install-recommends locales sudo vim pkg-config build-essential wget libc6 curl file git ruby \
	&& dpkg-reconfigure locales \
	&& update-locale LANG=en_US.UTF-8 \
	&& apt-get upgrade -y \
	&& update-ca-certificates --fresh \
	&& apt-cache policy ca-certificates \
	&& find /var/cache/apt/archives /var/lib/apt/lists -not -name lock -type f -delete \
	&& useradd -m -s /bin/bash linuxbrew

USER linuxbrew
WORKDIR /home/linuxbrew
ENV LANG=en_US.UTF-8 \
	PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH \
	SHELL=/bin/bash
RUN git clone https://github.com/Linuxbrew/brew.git /home/linuxbrew/.linuxbrew/Homebrew \
	&& mkdir /home/linuxbrew/.linuxbrew/bin \
	&& ln -s ../Homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/ \
	&& test -d ~/.linuxbrew \
	&& brew config && brew upgrade && brew update && brew install graphicsmagick ghostscript
	
	#&& ln -s /home/linuxbrew/.linuxbrew/bin/gm /usr/local/bin/gm \
	#&& ln -s /home/linuxbrew/.linuxbrew/bin/gs /usr/local/bin/gs

CMD ["/bin/bash"]