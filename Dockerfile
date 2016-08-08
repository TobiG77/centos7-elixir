FROM centos:centos7

MAINTAINER Tobias Gerschner <tobias.gerschner@gmail.com>

ENV ERLANG_VERSION 19.0
ENV ELIXIR_VERSION 1.3.2
ENV ELIXIR_BINARIES mix elixirc elixir iex

RUN yum -y install --setopt=tsflags=nodocs epel-release wget unzip uuid less bzip2 && \
    yum -y install http://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm && \
    yum -y install esl-erlang-${ERLANG_VERSION} && \
    yum -y update && yum clean all

RUN cd /tmp && \
    wget https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip && \
    unzip -d /usr/local/elixir -x Precompiled.zip && \
    rm -f /tmp/Precompiled.zip

ADD elixir_profile.sh /etc/profile.d/elixir.sh

RUN curl -sL https://rpm.nodesource.com/setup_6.x | bash -
RUN yum -y install nodejs
RUN npm install -g npm --prefix=/usr/local
RUN ln -s -f /usr/local/bin/npm /usr/bin/npm

CMD [ "/bin/bash" ]
