FROM lsiobase/xenial
MAINTAINER cajetan19

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV LANG="en_US.UTF-8" \
LANGUAGE="en_US:en"

# Set the locale
RUN \
 locale-gen en_US.UTF-8

# install packages
RUN \
 apt-get update && \
 apt-get install -y \
	bsdmainutils \
	bzip2 \
	curl \
	file \
	libmariadb2 \
	mailutils \
	postfix \
	python \
	tmux \
	util-linux \
	wget \
	x11vnc \
	xvfb \
	libxcursor1 \
	ca-certificates \
	python \
	libav-tools \
	nano \
	libglib2.0-0 && \

# cleanup
 apt-get clean && \
 rm -rf \
	/var/lib/apt/lists/* \
	/var/tmp/* && \

useradd sinusbot

# ports and volumes
EXPOSE 8087
VOLUME /config
