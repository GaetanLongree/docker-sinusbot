FROM ubuntu
MAINTAINER cajetan19

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV LANG="en_US.UTF-8" \
LANGUAGE="en_US:en"

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
	bzip2 \
	python \
	libav-tools && \

# cleanup
 apt-get clean && \
 rm -rf \
	/var/lib/apt/lists/* \
	/var/tmp/* && \

update-ca-certificates

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8087
VOLUME /config
