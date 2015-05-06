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

## dependencies 
RUN env DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get -q -y upgrade && \
    apt-get -q -y install \
      make build-essential llvm curl git sudo byobu \
      libc6-dev libreadline6-dev zlib1g-dev libbz2-dev libncursesw5-dev \
      libssl-dev libgdbm-dev libdb-dev libsqlite3-dev liblzma-dev tk-dev \
      libexpat1-dev libmpdec-dev libffi-dev libzmq3-dev pandoc mime-support locales-all && \
    apt-get clean

## user setup
RUN useradd -G sudo -m pyuser && \
    echo "Defaults    !authenticate" >> /etc/sudoers

USER pyuser
ENV HOME /home/pyuser
ENV USER pyuser
ENV PYENV_ROOT ${HOME}/.pyenv
WORKDIR /home/pyuser

## pyenv setup
RUN git clone --quiet --depth 1 https://github.com/yyuu/pyenv.git ${PYENV_ROOT} && \
    echo 'eval "$(pyenv init -)"' >> ${HOME}/.bashrc
ENV PATH ${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}

## pyenv-virtualenv plugin
RUN git clone --quiet --depth 1 https://github.com/yyuu/pyenv-virtualenv.git ${PYENV_ROOT}/plugins/pyenv-virtualenv

## install python
RUN pyenv install ${PY2_VER} && pyenv rehash && \
    pyenv global ${PY2_VER} && pip install -U pip

## working environment for developer
RUN mkdir -p ${HOME}/workspace && \
    byobu-enable

## docker configurations
VOLUME ["${HOME}/workspace"]
ENTRYPOINT ["/bin/bash"]

## now you can run here by 'docker run -it miurahr/pyvenv'
## It automatically launch shell and byobu.
## Please don't forget add '-it'(interactive/terminal) argument option.
## Docker will enter guest environment as non-login session.
