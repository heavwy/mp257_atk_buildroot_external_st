LIBRETRO_FCEUMM_VERSION = master
LIBRETRO_FCEUMM_SITE = $(call github,libretro,libretro-fceumm,$(LIBRETRO_FCEUMM_VERSION))

define LIBRETRO_FCEUMM_BUILD_CMDS
	# 核心修改：
	# 1. 注入 LDFLAGS="-lm" 解决 sin/cos/pow 等数学函数未定义问题
	# 2. 保持 LD="$(TARGET_CC)" 确保链接器参数识别正确
	$(TARGET_MAKE_ENV) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) \
		-f Makefile.libretro \
		platform=unix \
		LD="$(TARGET_CC)" \
		CFLAGS="$(TARGET_CFLAGS) -DFCEU_VERSION_NUMERIC=9813" \
		LDFLAGS="$(TARGET_LDFLAGS) -lm"
endef

define LIBRETRO_FCEUMM_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0644 $(@D)/fceumm_libretro.so \
        $(TARGET_DIR)/usr/lib/libretro/fceumm_libretro.so
endef

$(eval $(generic-package))