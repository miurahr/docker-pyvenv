#!/bin/bash -e
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

source /etc/bash.bashrc
export PYENV_ROOT=${PYENV_ROOT:-/opt/pyapp/.pyenv}
export PATH=${PYENV_ROOT}/bin:${PYENV_ROOT}/shims:${PATH}

function install_python_version () {
  local ver=$1

  pyenv install $ver
  pyenv rehash
  pyenv global  $ver
  pip install --upgrade pip
}


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
