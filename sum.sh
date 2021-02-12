#!/bin/bash

npm install -g checksum

sum_file () {
  if [[ -f "$1" ]]; then
    checksum -a sha256 "$1" > "$1".sha256
    checksum "$1" > "$1".sha1
  fi
}

if [[ "$SHOULD_BUILD" == "yes" ]]; then
  if [[ "$OS_NAME" == "osx" ]]; then
    sum_file Codium-darwin-*.zip
    sum_file Codium*.dmg
  elif [[ "$OS_NAME" == "windows" ]]; then
    sum_file CodiumSetup-*.exe
    sum_file CodiumUserSetup-*.exe
    sum_file Codium-win32-*.zip
  else # linux
    cp out/*.AppImage* .
    cp vscode/.build/linux/deb/*/deb/*.deb .
    cp vscode/.build/linux/rpm/*/*.rpm .

    sum_file *.AppImage
    sum_file Codium-linux*.tar.gz
    sum_file *.deb
    sum_file *.rpm
  fi
fi
