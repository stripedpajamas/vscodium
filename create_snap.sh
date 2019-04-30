#!/bin/bash

if [[ "$BUILDARCH" == "x64" ]]; then
  set -ex
  snapcraft --version
  sudo apt-get upgrade -y
  REPO="$(pwd)"
  ARCH="$BUILDARCH"
  SNAP_ROOT="$REPO/.build/linux/snap/$ARCH"
  (cd build && yarn)
  SNAP_TARBALL_PATH="$REPO/.build/linux/snap-tarball/snap-$ARCH.tar.gz"
  (cd .build/linux && tar -xzf $SNAP_TARBALL_PATH)
  BUILD_VERSION="$(date +%s)"
  SNAP_FILENAME="vscodium-$BUILD_VERSION.snap"
  PACKAGEJSON="$(ls $SNAP_ROOT/vscodium*/usr/share/vscodium*/resources/app/package.json)"
  VERSION=$(node -p "require(\"$PACKAGEJSON\").version")
  SNAP_PATH="$SNAP_ROOT/$SNAP_FILENAME"
  (cd $SNAP_ROOT/vscodium-* && sudo snapcraft snap --output "$SNAP_PATH")
fi