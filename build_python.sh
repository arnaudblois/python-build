#!/bin/bash

set -euo pipefail

default_version=3.15.2
read -r -p "Enter the version to build [${default_version}]: " version
version=${version:-$default_version}

if [[ ! "$version" =~ ^3\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)$ ]]; then
  printf 'Invalid version: %s. Enter a stable Python 3 version such as %s.\n' "$version" "$default_version" >&2
  exit 1
fi

printf 'Building Python version %s\n' "$version"

sudo apt-get update
sudo apt-get install -y \
  build-essential \
  libbz2-dev \
  libffi-dev \
  libgdbm-dev \
  liblzma-dev \
  libncurses5-dev \
  libnss3-dev \
  libreadline-dev \
  libsqlite3-dev \
  libssl-dev \
  libzstd-dev \
  pkg-config \
  tk-dev \
  wget \
  zlib1g-dev

build_dir=$(mktemp -d -t python-build.XXXXXXXXXX)
trap 'rm -rf -- "$build_dir"' EXIT
trap 'exit 130' INT
trap 'exit 143' TERM

wget "https://www.python.org/ftp/python/${version}/Python-${version}.tgz" -O - | tar -xz -C "$build_dir"
cd "$build_dir/Python-${version}"
./configure --enable-optimizations --with-lto --enable-loadable-sqlite-extensions
make -j"$(nproc)"
sudo make altinstall

printf 'Python %s has been successfully installed and is accessible at /usr/local/bin/python%s.\n' "$version" "${version%.*}"
