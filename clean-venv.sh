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
## clean up
env DEBIAN_FRONTEND=noninteractive apt-get -y remove git \
    libc6-dev libreadline6-dev zlib1g-dev libbz2-dev libncursesw5-dev \
    libssl-dev libgdbm-dev libdb-dev libsqlite3-dev liblzma-dev tk-dev \
    libexpat1-dev libmpdec-dev libffi-dev
env DEBIAN_FRONTEND=noninteractive apt-get -y autoremove
env DEBIAN_FRONTEND=noninteractive apt-get clean

exit 0
