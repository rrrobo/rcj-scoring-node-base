FROM centos:7
MAINTAINER ryorobo <rrrobo@icloud.com>

COPY ./docker/nginx.repo /etc/yum.repos.d/nginx.repo
COPY ./docker/mongodb.repo /etc/yum.repos.d/mongodb.repo
COPY ./docker/nginx.conf /etc/nginx/nginx.conf

RUN set -x && \
    yum update -y && \
    yum install -y nginx mongodb-org && \
    yum install gcc-c++ make cmake git python wget -y && \
    curl -sL https://rpm.nodesource.com/setup_10.x | bash - && \
    yum install nodejs -y

RUN mkdir -p /opt/rcj-scoring-system
COPY ./package.json /opt/rcj-scoring-system/package.json
COPY ./bower.json /opt/rcj-scoring-system/bower.json
COPY ./.bowerrc /opt/rcj-scoring-system/.bowerrc
WORKDIR /opt/rcj-scoring-system

RUN npm install && \
    npm install bower -g && \
    npm install workbox-cli -g && \
    bower install --allow-root && \
    mkdir logs && \
    mkdir /data/db -p && \
    mkdir -p /opt/rcj-scoring-system/tmp/course && \
    mkdir -p /opt/rcj-scoring-system/tmp/uploads

WORKDIR /
COPY ./docker/start.sh /start.sh
RUN chmod +x start.sh && \
    yum remove -y wget git