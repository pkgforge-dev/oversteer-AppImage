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
export PATH_MAPPING='
	/usr/share/locale:${SHARUN_DIR}/share/locale
	/sbin/ldconfig:${SHARUN_DIR}/bin/ldconfig
'

# Deploy dependencies
quick-sharun /usr/bin/oversteer /usr/lib/libgirepository* /usr/lib/libudev.so* /sbin/ldconfig

# Add udev rules
mkdir -p ./AppDir/etc/udev/rules.d
cp /usr/lib/udev/rules.d/*wheel-perms* ./AppDir/etc/udev/rules.d

sed -i -e 's|/etc/ld.so.cache|/tmp/ld.so.cache|g' ./AppDir/bin/ldconfig
echo '#!/bin/sh
if command -v ldconfig 1>/dev/null && [ ! -f /tmp/ld.so.cache ]; then
	exec ldconfig
fi
' > ./AppDir/bin/ldconfig.hook

# Turn AppDir into AppImage
quick-sharun --make-appimage
