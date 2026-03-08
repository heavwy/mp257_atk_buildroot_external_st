FCEUX_VERSION = 2.6.6
FCEUX_SITE = $(call github,TASEmulators,fceux,v$(FCEUX_VERSION))
# 依赖项保持你现在的 minizip-zlib
FCEUX_DEPENDENCIES = sdl2 zlib libpng libarchive lua qt5base minizip-zlib host-pkgconf

FCEUX_CONF_OPTS = \
	-DQT=ON \
	-DSDL2=ON \
	-DGTK=OFF \
	-DOPENGL=ON \
	-DGLVND=OFF \
	-DCREATE_DEB=OFF \
	-DENABLE_X86=OFF \
	-DENABLE_AMD64=OFF \
	-DENABLE_LTO=OFF \
	-DOPENGL_opengl_LIBRARY=$(STAGING_DIR)/usr/lib/libGLESv2.so \
	-DOPENGL_glx_LIBRARY=$(STAGING_DIR)/usr/lib/libGLESv2.so \
	-DOPENGL_INCLUDE_DIR=$(STAGING_DIR)/usr/include

$(eval $(cmake-package))