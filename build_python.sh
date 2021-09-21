#!/bin/bash

set -e

sudo apt-get update
sudo apt-get dist-upgrade -y
sudo apt-get install -y \
  build-essential \
  libbz2-dev \
  libffi-dev \
  libgdbm-dev \
  liblzma-dev \
  libncurses5-dev \
  libnss3-dev \
  libsqlite3-dev \
  libssl-dev \
  wget \
  zlib1g-dev

# Script building the required version of python
read -p "Enter the version to build [3.9.7]: " version
version=${version:-3.9.7}
echo "Building Python version ${version}"

wget https://www.python.org/ftp/python/${version}/Python-${version}.tgz -O - | tar -xz
cd Python-${version}
./configure --enable-optimizations --with-lto --enable-loadable-sqlite-extensions
make
sudo make altinstall
cd ..
sudo rm -rf Python-${version}

echo "Python ${version} has been successfully installed and is accessible at /usr/local/bin/python3."
