#!/bin/bash

set -ex

if [[ "$SHOULD_BUILD" == "yes" ]]; then
  npm config set scripts-prepend-node-path true

  echo "LATEST_MS_COMMIT: ${LATEST_MS_COMMIT}"

  # set fields in product.json
  tipsAndTricksUrl='setpath(["tipsAndTricksUrl"]; "https://go.microsoft.com/fwlink/?linkid=852118")'
  twitterUrl='setpath(["twitterUrl"]; "https://go.microsoft.com/fwlink/?LinkID=533687")'
  requestFeatureUrl='setpath(["requestFeatureUrl"]; "https://go.microsoft.com/fwlink/?LinkID=533482")'
  documentationUrl='setpath(["documentationUrl"]; "https://go.microsoft.com/fwlink/?LinkID=533484#vscode")'
  introductoryVideosUrl='setpath(["introductoryVideosUrl"]; "https://go.microsoft.com/fwlink/?linkid=832146")'
  extensionAllowedBadgeProviders='setpath(["extensionAllowedBadgeProviders"]; ["api.bintray.com", "api.travis-ci.com", "api.travis-ci.org", "app.fossa.io", "badge.fury.io", "badge.waffle.io", "badgen.net", "badges.frapsoft.com", "badges.gitter.im", "badges.greenkeeper.io", "cdn.travis-ci.com", "cdn.travis-ci.org", "ci.appveyor.com", "circleci.com", "cla.opensource.microsoft.com", "codacy.com", "codeclimate.com", "codecov.io", "coveralls.io", "david-dm.org", "deepscan.io", "dev.azure.com", "flat.badgen.net", "gemnasium.com", "githost.io", "gitlab.com", "godoc.org", "goreportcard.com", "img.shields.io", "isitmaintained.com", "marketplace.visualstudio.com", "nodesecurity.io", "opencollective.com", "snyk.io", "travis-ci.com", "travis-ci.org", "visualstudio.com", "vsmarketplacebadge.apphb.com", "www.bithound.io", "www.versioneye.com"])'
  updateUrl='setpath(["updateUrl"]; "https://vscodium.now.sh")'
  releaseNotesUrl='setpath(["releaseNotesUrl"]; "https://go.microsoft.com/fwlink/?LinkID=533483#vscode")'
  keyboardShortcutsUrlMac='setpath(["keyboardShortcutsUrlMac"]; "https://go.microsoft.com/fwlink/?linkid=832143")'
  keyboardShortcutsUrlLinux='setpath(["keyboardShortcutsUrlLinux"]; "https://go.microsoft.com/fwlink/?linkid=832144")'
  keyboardShortcutsUrlWin='setpath(["keyboardShortcutsUrlWin"]; "https://go.microsoft.com/fwlink/?linkid=832145")'
  quality='setpath(["quality"]; "stable")'
  extensionsGallery='setpath(["extensionsGallery"]; {"serviceUrl": "https://marketplace.visualstudio.com/_apis/public/gallery", "cacheUrl": "https://vscode.blob.core.windows.net/gallery/index", "itemUrl": "https://marketplace.visualstudio.com/items"})'
  nameShort='setpath(["nameShort"]; "Codium")'
  nameLong='setpath(["nameLong"]; "Codium")'
  linuxIconName='setpath(["linuxIconName"]; "codium")'
  applicationName='setpath(["applicationName"]; "codium")'
  win32MutexName='setpath(["win32MutexName"]; "codium")'
  win32DirName='setpath(["win32DirName"]; "Codium")'
  win32NameVersion='setpath(["win32NameVersion"]; "Codium")'
  win32RegValueName='setpath(["win32RegValueName"]; "Codium")'
  win32AppUserModelId='setpath(["win32AppUserModelId"]; "Microsoft.Codium")'
  win32ShellNameShort='setpath(["win32ShellNameShort"]; "Codium")'
  win32x64UserAppId='setpath (["win32x64UserAppId"]; "{{2E1F05D1-C245-4562-81EE-28188DB6FD17}")'
  urlProtocol='setpath(["urlProtocol"]; "codium")'
  extensionAllowedProposedApi='setpath(["extensionAllowedProposedApi"]; getpath(["extensionAllowedProposedApi"]) + ["ms-vsliveshare.vsliveshare"])'

  cd vscode || exit

  yarn monaco-compile-check
  yarn valid-layers-check

  yarn gulp compile-build
  yarn gulp compile-extensions-build
  yarn gulp minify-vscode

  if [[ "$OS_NAME" == "osx" ]]; then
    yarn gulp "vscode-darwin-${VSCODE_ARCH}-min-ci"
  elif [[ "$OS_NAME" == "windows" ]]; then
    cp LICENSE.txt LICENSE.rtf # windows build expects rtf license
    yarn gulp "vscode-win32-${VSCODE_ARCH}-min-ci"
    yarn gulp "vscode-win32-${VSCODE_ARCH}-code-helper"
    yarn gulp "vscode-win32-${VSCODE_ARCH}-inno-updater"
    yarn gulp "vscode-win32-${VSCODE_ARCH}-archive"
    yarn gulp "vscode-win32-${VSCODE_ARCH}-system-setup"
    yarn gulp "vscode-win32-${VSCODE_ARCH}-user-setup"
  else # linux
    yarn gulp "vscode-linux-${VSCODE_ARCH}-min-ci"
    if [[ "$SKIP_LINUX_PACKAGES" != "True" ]]; then
      yarn gulp "vscode-linux-${VSCODE_ARCH}-build-deb"
      yarn gulp "vscode-linux-${VSCODE_ARCH}-build-rpm"
      . ../create_appimage.sh
    fi
  fi

  cd ..
fi
