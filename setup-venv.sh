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
# Environment variable for building
#
# if PY_VERS is not empty, it build all of python versions.
#  and set PY_VER as default.
#
#  only PY_VER defined, it build with python with PY_VER
#  no varialble defined, it set default as follows:
PY_VER=${PY_VER:-3.4.3}

if [ "${PY_VERS}" == "" ]; then
  echo "setup pyenv with Python ${PY_VER}."
else
  echo "setup pyenv with Python versions: ${PY_VERS}."
  echo "default version is ${PY_VER}."
fi

## user setup
PYAPP_ROOT=${PYAPP_ROOT:-/opt/pyapp}
PYENV_ROOT=${PYENV_ROOT:-/opt/pyapp/.pyenv}
RC_FILE=/etc/bash.bashrc

function install_python_version () {
  local ver=$1

  run_as_user pyenv install $ver
  run_as_user pyenv rehash
  run_as_user pyenv global  $ver
  run_as_user pip install -U pip
}

source $RC_FILE

## install python
if [ "${PY_VERS}" == "" ]; then
  # single version install
  install_python_version ${PY_VER}
else
  for v in ${PY_VERS} ; do
    install_python_version $v
  done
fi

exit 0
