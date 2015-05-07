#!/bin/bash
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
# project home: github.com/miurahr/docker-pyvenv-dev
#
####################################################
set -e

env DEBIAN_FRONTEND=noninteractive apt-get update
env DEBIAN_FRONTEND=noninteractive apt-get -q -y upgrade
env DEBIAN_FRONTEND=noninteractive apt-get -q -y install \
    make build-essential llvm curl git sudo \
    libreadline6 zlib1g libbz2-1.0 libncursesw5 libssl1.0.0 \
    libgdbm3 libdb5.3  libsqlite3-0 liblzma5 libtk8.6 \
    libexpat1 libmpdec2 libffi6 \
    libc6-dev libreadline6-dev zlib1g-dev libbz2-dev libncursesw5-dev \
    libssl-dev libgdbm-dev libdb-dev libsqlite3-dev liblzma-dev tk-dev \
    libexpat1-dev libmpdec-dev libffi-dev \
    mime-support

## user setup
RUN_USER=${RUN_USER:-pyapp}
PYAPP_ROOT=${PYAPP_ROOT:-/opt/pyapp}
PYENV_ROOT=${PYENV_ROOT:-/opt/pyapp/.pyenv}
RC_FILE=/etc/bash.bashrc

function run_as_user () {
  sudo -u ${RUN_USER} -E -H env PATH=${PATH} $*
}

useradd -d ${PYAPP_ROOT} -m ${RUN_USER}

## pyenv setup
run_as_user git clone --quiet --depth 1 https://github.com/yyuu/pyenv.git ${PYENV_ROOT}
run_as_user git clone --quiet --depth 1 https://github.com/yyuu/pyenv-virtualenv.git ${PYENV_ROOT}/plugins/pyenv-virtualenv

echo "export PYENV_ROOT=${PYENV_ROOT}" >> $RC_FILE
echo "export PATH=${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}" >> $RC_FILE
echo 'eval "$(pyenv init -)"' >> $RC_FILE
echo 'eval "$(pyenv virtualenv-init -)"' >> $RC_FILE

exit 0
