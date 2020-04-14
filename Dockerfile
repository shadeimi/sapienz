# pull official base image
FROM lsiobase/alpine:3.11

RUN \
 echo "**** install build packages ****" && \
 apk add --no-cache --virtual=build-dependencies \
	autoconf \
	automake \
	freetype-dev \
	g++ \
	gcc \
	jpeg-dev \
	lcms2-dev \
	libffi-dev \
	libpng-dev \
	libwebp-dev \
	libxml2-dev \
	libxslt-dev \
	linux-headers \
	make \
	openjpeg-dev \
	openssl-dev \
	python2-dev \
	tiff-dev \
	zlib-dev && \
 echo "**** install runtime packages ****" && \
 apk add --no-cache \
	curl \
	freetype \
	git \
	lcms2 \
	libjpeg-turbo \
	libwebp \
	libxml2 \
	libxslt \
	openjpeg \
	openssl \
	p7zip \
	py2-pip \
	python2 \
	tar \
	tiff \
	unrar \
	unzip \
	vnstat \
	wget \
	xz \
	pkgconfig \
	zlib && \
 echo "**** install pip packages ****" && \
 pip install --no-cache-dir -U \
	pip && \
 pip install -U \
	configparser \
	numpy \
	psutil \
	pyopenssl \
	requests \
	setuptools \
	urllib3 \
	virtualenv && \
 echo "**** clean up ****" && \
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/root/.cache \
	/tmp/*

# copy sapienz project
COPY . /usr/src/sapienz/

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt /usr/src/sapienz/
RUN pip install -r /usr/src/sapienz/requirements.txt

ENTRYPOINT ["/usr/src/sapienz/entrypoint.sh"]

