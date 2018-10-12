#!/bin/bash

if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
  brew update
  brew install yarn --without-node
  brew install jq zip
else
  sudo apt-get update
  sudo apt-get install libx11-dev libxkbfile-dev libsecret-1-dev fakeroot rpm
  if [[ "$BUILDARCH" == "ia32" ]]; then
    echo "Setting up env for i386"
    sudo dpkg --add-architecture i386
    sudo apt-get update
    sudo apt-get install libc6-dev-i386 gcc-multilib g++-multilib
    sudo apt-get install libx11-dev:i386 libxkbfile-dev:i386
  elif [[ $BUILDARCH == "arm64" ]]; then
    echo "Setting up env for arm64"
    deps="libx11-dev libxkbfile-dev libsecret-1-dev"
    lib_path=/usr/lib/aarch64-linux-gnu
    linkage_list="-L $lib_path -I/usr/include/aarch64-linux-gnu"
    for package in $deps; do
      linkage_list="$linkage_list -I/usr/lib/aarch64-linux-gnu/$package/include"
    done
    export CC="aarch64-linux-gnu-gcc $linkage_list"
    export CXX="aarch64-linux-gnu-g++ $linkage_list"
    sudo dpkg --add-architecture arm64
    ./arm_sources.sh
    sudo apt-get update
    sudo apt-get install dpkg-cross
    sudo apt-get install libx11-dev:arm64 libxkbfile-dev:arm64 libsecret-1-dev:arm64
  fi
fi
