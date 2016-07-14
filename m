From: mark.yao@rock-chips.com (Mark Yao)
Date: Thu, 14 Jul 2016 11:31:26 +0800
Subject: [PATCH 2/6] drm/rockchip: fb: add missing header
In-Reply-To: <1468467090-6108-1-git-send-email-mark.yao@rock-chips.com>
References: <1468467090-6108-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1468467090-6108-3-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: John Keeping <john@metanate.com>

This fixes the following sparse warnings:

drivers/gpu/drm/rockchip/rockchip_drm_fb.c:32:23: warning: symbol 'rockchip_fb_get_gem_obj' was not declared. Should it be static?
drivers/gpu/drm/rockchip/rockchip_drm_fb.c:315:24: warning: symbol 'rockchip_drm_framebuffer_init' was not declared. Should it be static?
drivers/gpu/drm/rockchip/rockchip_drm_fb.c:329:6: warning: symbol 'rockchip_drm_mode_config_init' was not declared. Should it be static?

Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 20f12bc..4fe2ab3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -20,6 +20,7 @@
 #include <drm/drm_crtc_helper.h>
 
 #include "rockchip_drm_drv.h"
+#include "rockchip_drm_fb.h"
 #include "rockchip_drm_gem.h"
 
 #define to_rockchip_fb(x) container_of(x, struct rockchip_drm_fb, fb)
-- 
1.9.1
