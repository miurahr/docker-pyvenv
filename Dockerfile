####################################################
# build pyenv developer environment on docker
#
# copyright 2015, Hiroshi Miura <miurahr@linux.com>
#
# It deeply depends on great work by @yyuu,
# please see github.com/yyuu/pyenv in details.
#
# this Dockerifile is licensed by MIT style license.
# see LICENSE for details
#
# project home: github.com/miurahr/docker-pyvenv
#
####################################################
#
FROM eboraas/debian:jessie
MAINTAINER miurahr@linux.com

## versions
ENV PY3_VER 3.4.3
ENV PY2_VER 2.7.9
ENV PYPY3_VER 2.4.0
ENV PYPY_VER  2.5.0

## working user
ENV RUN_USER pyuser
ENV RUN_HOME /home/pyuser

## python dependencies 
RUN env DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get -q -y upgrade && \
    apt-get -q -y install \
      make build-essential llvm curl git sudo \
      libc6-dev libreadline6-dev zlib1g-dev libbz2-dev libncursesw5-dev \
      libssl-dev libgdbm-dev libdb-dev libsqlite3-dev liblzma-dev tk-dev \
      libexpat1-dev libmpdec-dev libffi-dev libzmq3-dev pandoc mime-support locales-all && \
    apt-get clean

## user setup
RUN useradd -G sudo -d ${RUN_HOME} -m ${RUN_USER} && \
    echo "Defaults    !authenticate" >> /etc/sudoers
USER ${RUN_USER}
ENV HOME ${RUN_HOME}
ENV USER ${RUN_USER}
WORKDIR ${RUN_HOME}

## pyenv setup
RUN git clone --quiet --depth 1 https://github.com/yyuu/pyenv.git ${HOME}/.pyenv && \
    echo 'export PYENV_ROOT=${HOME}/.pyenv' >> ${HOME}/.bashrc && \
    echo 'eval "$(pyenv init -)"' >> ${HOME}/.bashrc

## working environment for developer
ENV PATH ${HOME}/.pyenv/shims:${HOME}/.pyenv/bin:${PATH}

## install python
RUN pyenv install ${PY3_VER}         && \
    pyenv rehash && \
    pyenv global ${PY3_VER}
