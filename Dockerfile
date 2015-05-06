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
RUN useradd -G sudo -m pyuser && \
    echo "Defaults    !authenticate" >> /etc/sudoers
USER pyuser
ENV HOME /home/pyuser
ENV USER pyuser
WORKDIR /home/pyuser

## pyenv setup
RUN git clone --quiet --depth 1 https://github.com/yyuu/pyenv.git ${HOME}/.pyenv && \
    echo 'export PYENV_ROOT=${HOME}/.pyenv' >> ${HOME}/.bashrc && \
    echo 'eval "$(pyenv init -)"' >> ${HOME}/.bashrc

## working environment for developer
ENV PATH ${HOME}/.pyenv/shims:${HOME}/.pyenv/bin:${PATH}

## docker configurations
ENTRYPOINT ["/bin/bash"]

## You can run here by 'docker run -it miurahr/pyvenv'
## It automatically launch shell.
## Please don't forget add '-it'(interactive/terminal) argument option.
## Docker will enter guest environment as non-login session.
##
## you may want to install python by 'pyenv install <version>' first time.
## and 'docker commit' to save its environment for further development.
