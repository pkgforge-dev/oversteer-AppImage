#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q oversteer | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/scalable/apps/io.github.berarma.Oversteer.svg
export DESKTOP=/usr/share/applications/io.github.berarma.Oversteer.desktop
export DEPLOY_GTK=1
export DEPLOY_SYS_PYTHON=1
export GTK_DIR=gtk-3.0
export DEPLOY_LOCALE=1
export ANYLINUX_LIB=1
export PATH_MAPPING='/usr/share/locale:${SHARUN_DIR}/share/locale'

# Deploy dependencies
quick-sharun /usr/bin/oversteer /usr/lib/libgirepository* /usr/lib/libudev.so*

# Add udev rules
mkdir -p ./AppDir/etc/udev/rules.d
cp /usr/lib/udev/rules.d/*wheel-perms* ./AppDir/etc/udev/rules.d

# add weird hack so that this works in alpine
echo 'LD_LIBRARY_PATH=/lib64:/usr/lib64:/lib:/usr/lib:${SHARUN_DIR}/lib' >> ./AppDir/.env
sed -i -e 's|LD_LIBRARY_PATH|LD_LIBRARY_KEK_|g' ./AppDir/shared/lib/anylinux.so

# Turn AppDir into AppImage
quick-sharun --make-appimage
