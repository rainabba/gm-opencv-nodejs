FROM justadudewhohacks/opencv-nodejs:node9-opencv3.4.1-contrib

LABEL maintainer="Michael Richardson <rainabba@gmail.com>"
LABEL repository="https://github.com/rainabba/gm-opencv-nodejs.git"

EXPOSE 5000 9229

ENV DEBIAN_FRONTEND=noninteractive \
	NODE_PATH=/usr/lib/node_modules \
	HOMEBREW_NO_ENV_FILTERING=1 \
	PATH=/home/linuxbrew/.linuxbrew/bin:/usr/lib/x86_64-linux-gnu/ImageMagick-6.8.9/bin-Q16:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin \
	LD_LIBRARY_PATH=/home/linuxbrew/.linuxbrew/lib \
	LANG=en_US.UTF-8 \
	LC_ALL=en_US.UTF-8 \
	LANGUAGE=en_US:en

ARG WORKDIR=/
WORKDIR ${WORKDIR}

COPY ./linuxbrew-graphics-magick.sh /

RUN useradd -m linuxbrew \
	&& apt-get update \
	&& apt-get upgrade -y \
	&& update-ca-certificates --fresh \
	&& apt-cache policy ca-certificates \
	&& apt-get install -y sudo locales vim pkg-config build-essential wget libc6 curl file git ruby \
	&& locale-gen "en_US.UTF-8" \
	&& echo -e 'LANG="en_US.UTF-8"\nLANGUAGE="en_US:en"\n' > /etc/default/locale \
	&& echo "America/Phoenix" > /etc/timezone \
	&& dpkg-reconfigure -f noninteractive tzdata \
	&& find /var/cache/apt/archives /var/lib/apt/lists -not -name lock -type f -delete \
	&& cd /home/linuxbrew \
	&& git clone https://github.com/Homebrew/linuxbrew.git ./.linuxbrew/ \
	&& chown -R linuxbrew:root /home/linuxbrew \
	&& chmod 770 /linuxbrew-graphics-magick.sh \
	&& chown -R linuxbrew:root /linuxbrew-graphics-magick.sh \
	&& sudo ln -s /home/linuxbrew/.linuxbrew/bin/gs /usr/local/bin/gs \
	&& sudo ln -s /home/linuxbrew/.linuxbrew/bin/gm /usr/local/bin/gm;

USER linuxbrew
RUN /linuxbrew-graphics-magick.sh

CMD ["/bin/bash"]