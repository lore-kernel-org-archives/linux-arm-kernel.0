From: john@metanate.com (John Keeping)
Date: Tue, 10 May 2016 17:03:55 +0100
Subject: [PATCH 2/3] drm/rockchip: fb: add missing header
In-Reply-To: <20160510160356.1167-1-john@metanate.com>
References: <20160510160356.1167-1-john@metanate.com>
Message-ID: <20160510160356.1167-3-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following sparse warnings:

drivers/gpu/drm/rockchip/rockchip_drm_fb.c:32:23: warning: symbol 'rockchip_fb_get_gem_obj' was not declared. Should it be static?
drivers/gpu/drm/rockchip/rockchip_drm_fb.c:315:24: warning: symbol 'rockchip_drm_framebuffer_init' was not declared. Should it be static?
drivers/gpu/drm/rockchip/rockchip_drm_fb.c:329:6: warning: symbol 'rockchip_drm_mode_config_init' was not declared. Should it be static?

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 8c10163a95bc..85aa87ee12f5 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -20,6 +20,7 @@
 #include <drm/drm_crtc_helper.h>
 
 #include "rockchip_drm_drv.h"
+#include "rockchip_drm_fb.h"
 #include "rockchip_drm_gem.h"
 
 #define to_rockchip_fb(x) container_of(x, struct rockchip_drm_fb, fb)
-- 
2.8.2.565.gdb84f68.dirty
