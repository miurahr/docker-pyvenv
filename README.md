docker-pyvenv
=============

[![Flattr this git repo](http://api.flattr.com/button/flattr-badge-large.png)](https://flattr.com/submit/auto?user_id=miurahr&url=https://github.com/miurahr/docker-pyvenv)

Python application development environment based on pyenv


How to use
-----------

Login, launch byobu and activating python

```
$ docker exec -it miurahr/pyvenv
```

Please see command details at [Pyenv Commands](https://github.com/yyuu/pyenv/blob/master/COMMANDS.md)


Deploy your application
-----------------------

You can deploy your production applicaiton by preparing Dockerfile
such as

```
FROM miurahr/pyvenv:3.4.3
COPY app /home/pyuser/app
ENV PYENV_VERSION 3.4.3
WORKDIR /home/pyuser/app
ENTRYPOINT ["/home/pyuser/app/wsgi-start.py"]
```

Directories and files
----------------------

* /home/pyuser/        - working user
* /home/pyuser/.pyenv/ - pyenv files

Guest user
------------

Guest user has sudo privilege and you can easily add more packages


Python Versions
----------------------

It has following python versions:

* tag latest

  - Python 3.4.3, 2.7.9
  - PyPy  2.5.0
  - PyPy3 2.4.0

* tag pypy

  - PyPy  2.5.0

* tag pypy3

  - PyPy3 2.4.0

* tag 3, 3.4

  - Python 3.4.3

* tag 2, 2.7

  - Python 2.7.9

ipython is also pre-installed.

How to build
--------------------

```
$ docker build -t pyvenv  .
```

License
-----------------
The MIT License (MIT)

Copyright (c) 2015 Hiroshi Miura

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
