# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2019-present Shanti Gilbert (https://github.com/shantigilbert)
# Copyright (C) 2021-present AmberELEC (https://github.com/AmberELEC)

PKG_NAME="openbor"
PKG_VERSION="f2999c43af2d6915180a959cb0776c45706f3744"
PKG_ARCH="any"
PKG_SITE="https://github.com/DCurrent/openbor"
PKG_URL="$PKG_SITE.git"
PKG_DEPENDS_TARGET="toolchain SDL2 libogg libvorbisidec libvpx libpng"
PKG_SHORTDESC="OpenBOR is the ultimate 2D side scrolling engine for beat em' ups, shooters, and more!"
PKG_LONGDESC="OpenBOR is the ultimate 2D side scrolling engine for beat em' ups, shooters, and more!"
PKG_TOOLCHAIN="make"
PKG_GIT_CLONE_BRANCH="global_beta"

pre_configure_target() {
  PKG_MAKE_OPTS_TARGET="BUILD_LINUX_${ARCH}=1 -C ${PKG_BUILD}/engine SDKPATH=${SYSROOT_PREFIX} PREFIX=${TARGET_NAME}"
  cd $PKG_BUILD
  #sed -i "s|device->mappings\[SDID_START\]      = SDL_CONTROLLER_BUTTON_START;|device->mappings\[SDID_START\]      = SDL_CONTROLLER_BUTTON_BACK;|g" engine/sdl/control.c
  #sed -i "s|device->mappings\[SDID_SCREENSHOT\] = SDL_CONTROLLER_BUTTON_BACK;|device->mappings\[SDID_SCREENSHOT\] = SDL_CONTROLLER_BUTTON_START;|g" engine/sdl/control.c
  sed -i "s|-Werror||g" engine/Makefile
  sed -i 's/\-O[23]//' engine/Makefile
}

pre_make_target() {
  cd $PKG_BUILD/engine
  ./version.sh
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  cp OpenBOR $INSTALL/usr/bin/OpenBOR
  cp $PKG_DIR/scripts/*.sh $INSTALL/usr/bin
  chmod +x $INSTALL/usr/bin/*
} 
