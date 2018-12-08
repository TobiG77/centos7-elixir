FROM centos:centos7

# for shipping releases
MAINTAINER Tobias Gerschner <tobias.gerschner@gmail.com>

ENV ERLANG_VERSION 21.1.3

# Set the locale(en_US.UTF-8)`
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN yum clean all && \
    yum -y install --setopt=tsflags=nodocs epel-release wget unzip uuid less bzip2 git-core inotify-tools && \
    yum -y install http://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm && \
    yum -y install esl-erlang-${ERLANG_VERSION} && \
    yum -y update && \
    yum -y reinstall glibc-common glibc && \
    yum clean all && \
    find /var/cache/yum -type f -exec rm -f '{}' \;

RUN localedef -i en_US -f UTF-8 en_US.UTF-8

RUN echo "export LANG=en_US.utf-8" >> /etc/environment
RUN echo "export LANGUAGE=en_US:en" >> /etc/environment
RUN echo "export LC_ALL=en_US.UTF-8" >> /etc/environment
