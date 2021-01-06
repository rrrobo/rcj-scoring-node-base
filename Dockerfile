FROM centos:8
MAINTAINER ryorobo <rrrobo@icloud.com>

COPY ./docker/nginx.repo /etc/yum.repos.d/nginx.repo
COPY ./docker/mongodb.repo /etc/yum.repos.d/mongodb.repo
COPY ./docker/nginx.conf /etc/nginx/nginx.conf

RUN set -x && \
    dnf update -y && \
    dnf install -y nginx mongodb-org && \
    dnf install git wget -y && \
    curl -sL https://rpm.nodesource.com/setup_14.x | bash - && \
    dnf install -y nodejs epel-release dnf-plugins-core && \
    dnf config-manager --set-enabled powertools && \
    dnf config-manager --set-enabled epel-playground && \
    rpm -ivh https://download1.rpmfusion.org/free/el/rpmfusion-free-release-8.noarch.rpm && \
    dnf install -y ffmpeg


RUN mkdir -p /opt/rcj-cms
COPY ./package.json /opt/rcj-cms/package.json
COPY ./bower.json /opt/rcj-cms/bower.json
COPY ./.bowerrc /opt/rcj-cms/.bowerrc
WORKDIR /opt/rcj-cms

RUN npm install && \
    npm install bower -g && \
    npm install workbox-cli -g && \
    bower install --allow-root && \
    mkdir logs && \
    mkdir /data/db -p && \
    mkdir -p /opt/rcj-cms/tmp/course && \
    mkdir -p /opt/rcj-cms/tmp/uploads

WORKDIR /
COPY ./docker/start.sh /start.sh
RUN chmod +x start.sh && \
    dnf remove -y wget git
