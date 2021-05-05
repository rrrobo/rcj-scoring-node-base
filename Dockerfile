FROM node:16-alpine
RUN apk --update add --no-cache ffmpeg git zip unzip
RUN apk add --no-cache --virtual build-dependencies wget \
    alpine-sdk \
    cmake \
    clang \
    shadow \
    gcc \                                                                                         
    musl-dev \                                                                                    
    autoconf \                                                                                    
    automake \                                                                                    
    make \                                                                                        
    libtool \                                                                                     
    nasm \                                                                                        
    tiff \                                                                                        
    jpeg \                                                                                        
    zlib \                                                                                        
    zlib-dev \                                                                                    
    file \                                                                                        
    pkgconf
RUN mkdir -p /opt/rcj-cms
WORKDIR /opt/rcj-cms
RUN wget https://raw.githubusercontent.com/rrrobo/rcj-rescue-scoring/master/package.json -O /opt/rcj-cms/package.json
RUN npm install
RUN npm install bower -g
RUN npm install workbox-cli -g
RUN wget https://raw.githubusercontent.com/rrrobo/rcj-rescue-scoring/master/bower.json -O /opt/rcj-cms/bower.json
RUN wget https://raw.githubusercontent.com/rrrobo/rcj-rescue-scoring/master/.bowerrc -O /opt/rcj-cms/.bowerrc
RUN bower install --allow-root
RUN apk del build-dependencies
RUN mkdir logs && \
    mkdir -p /opt/rcj-cms/tmp/course && \
    mkdir -p /opt/rcj-cms/tmp/uploads
WORKDIR /
COPY ./docker/start.sh /start.sh
RUN chmod +x start.sh
