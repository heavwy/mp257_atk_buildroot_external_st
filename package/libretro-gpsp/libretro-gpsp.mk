################################################################################
#
# libretro-gpsp
#
################################################################################

LIBRETRO_GPSP_VERSION = 4caf7a167d159866479ea94d6b2d13c26ceb3e72
LIBRETRO_GPSP_SITE = $(call github,libretro,gpsp,$(LIBRETRO_GPSP_VERSION))
LIBRETRO_GPSP_LICENSE = GPLv2

# STM32MP257 架构判断 (开启针对 ARM 的 Dynarec 优化)
ifeq ($(BR2_aarch64),y)
LIBRETRO_GPSP_PLATFORM = arm64
else ifeq ($(BR2_arm),y)
LIBRETRO_GPSP_PLATFORM = armv
else
LIBRETRO_GPSP_PLATFORM = unix
endif

# 编译命令 (剥离了 Batocera 专属的附加参数)
define LIBRETRO_GPSP_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) $(MAKE) CXX="$(TARGET_CXX)" CC="$(TARGET_CC)" \
		-C $(@D) platform=$(LIBRETRO_GPSP_PLATFORM)
endef

# 安装命令 (注意这里不加 -m 参数，默认赋予 0755 可执行权限)
define LIBRETRO_GPSP_INSTALL_TARGET_CMDS
	$(INSTALL) -D $(@D)/gpsp_libretro.so \
		$(TARGET_DIR)/usr/lib/libretro/gpsp_libretro.so
endef

$(eval $(generic-package))