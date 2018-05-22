FROM debian:latest
LABEL maintainer="gaetanlongree@gmail.com"

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update && \
	apt-get install -y libc-l10n && \
	apt-get install -y locales && \
	locale-gen en_US.UTF-8 && \
	apt-get install -y \
	wget \
	less \
	x11vnc \
	xvfb \
	libxcursor1 \
	ca-certificates \
	bzip2 \
	libnss3 \
	libegl1-mesa \
	x11-xkb-utils \
	libasound2 \
	libglib2.0-0 \
	python \
	libxcomposite-dev && \
    update-ca-certificates && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /var/tmp/* && \
# install youtube-dl
	wget -q -O /usr/local/bin/youtube-dl http://yt-dl.org/downloads/latest/youtube-dl && \
	chmod +x /usr/local/bin/youtube-dl

# Define user sinusbot
RUN mkdir /sinusbot /music && \
	useradd sinusbot -s /bin/bash -d /sinusbot && \
	chown sinusbot:sinusbot /sinusbot /music && \
	chmod 775 /sinusbot /music

USER sinusbot
WORKDIR /sinusbot

COPY entrypoint.sh /

# ports and volumes
EXPOSE 8080
VOLUME /sinusbot
VOLUME /music

ENTRYPOINT ["bash", "/entrypoint.sh"]