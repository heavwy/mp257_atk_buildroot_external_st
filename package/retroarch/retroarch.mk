RETROARCH_VERSION = 4b74434a30c534c763b60ba4cc16f6a94a611c5f
RETROARCH_SITE = $(call github,libretro,RetroArch,$(RETROARCH_VERSION))
RETROARCH_LICENSE = GPLv3+
RETROARCH_DEPENDENCIES = host-pkgconf libdrm gcnano-binaries zlib alsa-lib udev

# 依据 Batocera 宏定义
RETROARCH_TARGET_CFLAGS = -DEGL_NO_X11 -DLINUX

# 保留之前已经成功的环境注入
RETROARCH_CONF_ENV = \
	$(TARGET_CONFIGURE_OPTS) \
	CROSS_COMPILE="$(HOST_DIR)/bin/" \
	PKG_CONFIG="$(HOST_DIR)/bin/pkg-config" \
	PKG_CONFIG_SYSROOT_DIR="$(STAGING_DIR)" \
	PKG_CONFIG_LIBDIR="$(STAGING_DIR)/usr/lib/pkgconfig:$(STAGING_DIR)/usr/share/pkgconfig" \
	CFLAGS="$(TARGET_CFLAGS) $(RETROARCH_TARGET_CFLAGS) -I$(STAGING_DIR)/usr/include" \
	CXXFLAGS="$(TARGET_CXXFLAGS) $(RETROARCH_TARGET_CFLAGS) -I$(STAGING_DIR)/usr/include" \
	LDFLAGS="$(TARGET_LDFLAGS) -L$(STAGING_DIR)/usr/lib -L$(STAGING_DIR)/usr/lib/gcnano -lc"

# 核心修正：移除 --enable-floathard，AArch64 不需要它
RETROARCH_CONF_OPTS = \
	--prefix=/usr \
	--disable-oss \
	--disable-qt \
	--enable-threads \
	--enable-egl \
	--disable-opengl \
	--enable-opengles \
	--enable-kms \
	--enable-zlib \
	--disable-builtinzlib \
	--enable-alsa \
	--disable-wayland \
	--disable-x11  \
	--enable-udev

define RETROARCH_CONFIGURE_CMDS
	(cd $(@D); rm -f config.cache; \
		$(RETROARCH_CONF_ENV) \
		./configure \
		$(RETROARCH_CONF_OPTS) \
	)
endef

define RETROARCH_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define RETROARCH_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))