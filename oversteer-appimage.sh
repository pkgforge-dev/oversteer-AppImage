#!/bin/sh

set -eux

ARCH="$(uname -m)"
URUNTIME="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/uruntime2appimage.sh"
SHARUN="https://raw.githubusercontent.com/pkgforge-dev/Anylinux-AppImages/refs/heads/main/useful-tools/quick-sharun.sh"
VERSION="$(cat ~/version)"

export ADD_HOOKS="self-updater.bg.hook:udev-installer.hook"
export ICON=/usr/share/icons/hicolor/scalable/apps/io.github.berarma.Oversteer.svg
export DESKTOP=/usr/share/applications/io.github.berarma.Oversteer.desktop
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export OUTNAME=Oversteer-"$VERSION"-anylinux-"$ARCH".AppImage
export DEPLOY_LOCALE=1
export DEPLOY_GTK=1
export GTK_DIR=gtk-3.0

# Deploy dependencies
wget --retry-connrefused --tries=30 "$SHARUN" -O ./quick-sharun
chmod +x ./quick-sharun
./quick-sharun /usr/bin/oversteer /usr/bin/python*

# python needs to be added manually
cp -r /usr/lib/python3.* ./AppDir/lib

# Add udev rules
mkdir -p ./AppDir/etc/udev/rules.d
cp /usr/lib/udev/rules.d/*wheel-perms* ./AppDir/etc/udev/rules.d

# MAKE APPIMAGE WITH URUNTIME
wget --retry-connrefused --tries=30 "$URUNTIME" -O ./uruntime2appimage
chmod +x ./uruntime2appimage
./uruntime2appimage

mkdir -p ./dist
mv -v ./*.AppImage* ./dist
mv -v ~/version     ./dist
