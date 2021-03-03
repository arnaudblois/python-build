#!/bin/bash

set -e

# Script building the required version of python
read -p "Enter the version to build [3.9.2]: " version
version=${version:-3.9.2}
echo "Building Python version $version"

wget https://www.python.org/ftp/python/${version}/Python-${version}.tgz -O - | tar -xz
cd Python-${version}
./configure --enable-optimizations --with-lto
make
sudo make altinstall
cd ..
sudo rm -rf Python-${version}
