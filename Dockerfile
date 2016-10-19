FROM centos:centos7

MAINTAINER Tobias Gerschner <tobias.gerschner@gmail.com>

ENV ERLANG_VERSION 19.1
ENV ELIXIR_VERSION 1.3.4
ENV ELIXIR_BINARIES mix elixirc elixir iex

# Set the locale(en_US.UTF-8)
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV DEV_ACCOUNT developer

RUN yum -y install --setopt=tsflags=nodocs epel-release wget unzip uuid less bzip2 git-core inotify-tools && \
    yum -y install http://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm && \
    yum -y install esl-erlang-${ERLANG_VERSION} && \
    yum -y update && \
    yum -y reinstall glibc-common glibc && \
    yum clean all

RUN cd /tmp && \
    wget https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip && \
    unzip -d /usr/local/elixir -x Precompiled.zip && \
    rm -f /tmp/Precompiled.zip

ADD elixir_profile.sh /etc/profile.d/elixir.sh

RUN curl -sL https://rpm.nodesource.com/setup_6.x | bash -
RUN yum -y install nodejs
RUN npm install -g npm --prefix=/usr/local
RUN ln -s -f /usr/local/bin/npm /usr/bin/npm

RUN echo "export LANG=en_US.utf-8" >> /etc/bashrc
RUN echo "export LANGUAGE=en_US:en" >> /etc/bashrc
RUN echo "export LC_ALL=en_US.UTF-8" >> /etc/bashrc

# set up an user
RUN adduser ${DEV_ACCOUNT} -u 1000 -U -m
RUN mkdir -p /opt/code && chown ${DEV_ACCOUNT} /opt/code
RUN ln -s /opt/code /home/${DEV_ACCOUNT}/code

RUN su -lc "PATH=$PATH:/usr/local/elixir/bin mix local.hex --force" ${DEV_ACCOUNT}
RUN su -lc "PATH=$PATH:/usr/local/elixir/bin mix local.rebar --force" ${DEV_ACCOUNT}

CMD [ "/bin/su", "--login", "developer" ]
