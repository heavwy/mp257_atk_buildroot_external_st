################################################################################
#
# libretro-mgba
#
################################################################################

LIBRETRO_MGBA_VERSION = 97c4de34889fc990119f7d9a95167f623f17e27d
LIBRETRO_MGBA_SITE = $(call github,mgba-emu,mgba,$(LIBRETRO_MGBA_VERSION))
LIBRETRO_MGBA_LICENSE = MPLv2.0

LIBRETRO_MGBA_DEPENDENCIES = zlib libpng libzip retroarch

# 核心编译选项
LIBRETRO_MGBA_CONF_OPTS += \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_LIBRETRO=ON \
    -DSKIP_LIBRARY=ON \
    -DBUILD_QT=OFF \
    -DBUILD_SDL=OFF \
    -DUSE_SQLITE3=OFF \
    -DUSE_MINIZIP=ON \
    -DUSE_EDITLINE=OFF \
    -DUSE_EPOXY=OFF

# 针对 STM32MP257 (Vivante GPU) 的强制 GLES 优化
LIBRETRO_MGBA_CONF_OPTS += \
    -DBUILD_GL=OFF \
    -DBUILD_GLES3=ON \
    -DBUILD_GLES2=OFF

# 安装路径 (注意：默认自带 0755 可执行权限)
define LIBRETRO_MGBA_INSTALL_TARGET_CMDS
    $(INSTALL) -D $(@D)/mgba_libretro.so \
        $(TARGET_DIR)/usr/lib/libretro/mgba_libretro.so
endef

$(eval $(cmake-package))
