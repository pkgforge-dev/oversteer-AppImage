# Oversteer-AppImage 🐧

[![GitHub Downloads](https://img.shields.io/github/downloads/pkgforge-dev/Oversteer-AppImage/total?logo=github&label=GitHub%20Downloads)](https://github.com/pkgforge-dev/Oversteer-AppImage/releases/latest)
[![CI Build Status](https://github.com//pkgforge-dev/Oversteer-AppImage/actions/workflows/appimage.yml/badge.svg)](https://github.com/pkgforge-dev/Oversteer-AppImage/releases/latest)

* [Latest Stable Release](https://github.com/pkgforge-dev/Oversteer-AppImage/releases/latest)

---

# Known issues

* On alpine linux (and maybe similar distros) you will need to have a C compiler installed, since for some weird reason the pyudev library needs to compile something at runtime.

---

AppImage made using [sharun](https://github.com/VHSgunzo/sharun), which makes it extremely easy to turn any binary into a portable package without using containers or similar tricks.

**This AppImage bundles everything and should work on any linux distro, even on musl based ones.**

It is possible that this appimage may fail to work with appimagelauncher, I recommend these alternatives instead: 

* [AM](https://github.com/ivan-hc/AM) `am -i oversteer` or `appman -i oversteer`

* [dbin](https://github.com/xplshn/dbin) `dbin install oversteer.appimage`

* [soar](https://github.com/pkgforge/soar) `soar install oversteer`

This AppImage can work **without FUSE** at all thanks to the [uruntime](https://github.com/VHSgunzo/uruntime)

<details>
  <summary><b><i>raison d'être</i></b></summary>
    <img src="https://github.com/user-attachments/assets/d40067a6-37d2-4784-927c-2c7f7cc6104b" alt="Inspiration Image">
  </a>
</details>

---

More at: [AnyLinux-AppImages](https://pkgforge-dev.github.io/Anylinux-AppImages/) 
