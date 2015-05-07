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
FROM ubuntu:14.04.2
MAINTAINER miurahr@linux.com

ENV PY_VER 3.4.3
ENV RUN_USER pyuser
ENV PYAPP_ROOT /opt/pyapp
ENV PYENV_ROOT ${PYAPP_ROOT}/.pyenv

COPY setup-venv.sh /tmp/
COPY prepare-venv.sh /tmp/
COPY clean-venv.sh /tmp/
RUN chmod +x /tmp/*-venv.sh
RUN /tmp/prepare-venv.sh

USER ${RUN_USER}
RUN /tmp/setup-venv.sh

USER root
RUN /tmp/clean-venv.sh

## docker execute setup
USER ${RUN_USER}
ENV HOME ${PYAPP_ROOT}
ENV USER ${RUN_USER}
WORKDIR ${PYAPP_ROOT}
