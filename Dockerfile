FROM centos:centos7

MAINTAINER Tobias Gerschner <tobias.gerschner@gmail.com>

ENV ERLANG_VERSION 18.3
ENV ELIXIR_VERSION 1.2.5
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

CMD [ "/bin/bash" ]
