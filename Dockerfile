# pull official base image
FROM lsiobase/alpine:3.11

RUN apk add --no-cache --virtual=build-dependencies autoconf automake freetype-dev g++ gcc jpeg-dev lcms2-dev libffi-dev libpng-dev libwebp-dev \
	libxml2-dev libxslt-dev linux-headers make openjpeg-dev openssl-dev python2-dev tiff-dev zlib-dev 
	
RUN apk add --no-cache curl freetype git lcms2 libjpeg-turbo libwebp libxml2 libxslt openjpeg openssl p7zip py2-pip python2 tar tiff \
	unrar unzip vnstat wget xz pkgconfig zlib 
	
RUN pip install --no-cache-dir -U pip 
RUN pip install -U wheel 
RUN pip install -U numpy matplotlib psutil 

COPY . /usr/src/sapienz/

COPY ./requirements.txt /usr/src/sapienz/
RUN pip install -r /usr/src/sapienz/requirements.txt

RUN apk del --purge build-dependencies 
RUN rm -rf /root/.cache /tmp/*

ENTRYPOINT ["/usr/src/sapienz/entrypoint.sh"]

