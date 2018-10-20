#!/bin/bash

if [[ "$SHOULD_BUILD" == "yes" ]]; then
  if [[ "$TRAVIS_OS_NAME" == "osx" ]]; then
    cd VSCode-darwin
    zip -r ../VSCode-darwin-${LATEST_MS_TAG}.zip ./*
  elif [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
    if [[ "$BUILDARCH" == "ia32" ]]; then
      cd VSCode-linux-ia32
      tar czf ../VSCode-linux-ia32-${LATEST_MS_TAG}.tar.gz .
    elif [[ "$BUILDARCH" == "arm64" ]]; then
      cd VSCode-linux-arm64
      tar czf ../VSCode-linux-arm64-${LATEST_MS_TAG}.tar.gz .
    else
      cd VSCode-linux-x64
      tar czf ../VSCode-linux-x64-${LATEST_MS_TAG}.tar.gz .
    fi
  elif [[ "$TRAVIS_OS_NAME" == "windows" ]]; then
    mv vscode/.build/win32-x64/system-setup/VSCodeSetup.exe vscode/.build/win32-x64/system-setup/VSCode-win32-x64-${LATEST_MS_TAG}-system-setup.exe
    mv vscode/.build/win32-x64/user-setup/VSCodeSetup.exe vscode/.build/win32-x64/user-setup/VSCode-win32-x64-${LATEST_MS_TAG}-user-setup.exe
    mv vscode/.build/win32-x64/archive/VSCode-win32-x64.zip vscode/.build/win32-x64/archive/VSCode-win32-x64-${LATEST_MS_TAG}.zip
  fi
  cd ..
fi