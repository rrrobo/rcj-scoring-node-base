FROM node:14-alpine
RUN apk --update add --no-cache ffmpeg git zip unzip
RUN apk add --no-cache --virtual build-dependencies wget
RUN mkdir -p /opt/rcj-cms
WORKDIR /opt/rcj-cms
RUN wget https://raw.githubusercontent.com/rrrobo/rcj-rescue-scoring/master/package.json -O /opt/rcj-cms/package.json
RUN npm install --production --ignore-scripts
RUN npm install bower -g
RUN wget https://raw.githubusercontent.com/rrrobo/rcj-rescue-scoring/master/bower.json -O /opt/rcj-cms/bower.json
RUN wget https://raw.githubusercontent.com/rrrobo/rcj-rescue-scoring/master/.bowerrc -O /opt/rcj-cms/.bowerrc
RUN bower install --allow-root
RUN apk del build-dependencies
RUN npm uninstall bower -g
