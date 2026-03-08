INFONES_VERSION = local
INFONES_SITE = /home/mp257_atk/InfoNES
INFONES_SITE_METHOD = local
# 必须加上 host-pkgconf，它是自动找库路径的工具
INFONES_DEPENDENCIES = sdl2 host-pkgconf

define INFONES_BUILD_CMDS
	cd $(@D); \
	$(TARGET_MAKE_ENV) $(TARGET_CXX) $(TARGET_CFLAGS) $(TARGET_CXXFLAGS) $(TARGET_LDFLAGS) \
		-I./src -fpermissive -std=c++11 -Wno-write-strings \
		`$(PKG_CONFIG_HOST_BINARY) --cflags --libs sdl2` \
		src/InfoNES.cpp \
		src/InfoNES_Mapper.cpp \
		src/InfoNES_pAPU.cpp \
		src/K6502.cpp \
		src/sdl/InfoNES_System_SDL.cpp \
		-o infones -lpthread -lm
endef

define INFONES_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/infones $(TARGET_DIR)/usr/bin/infones
endef

$(eval $(generic-package))