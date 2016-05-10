From: john@metanate.com (John Keeping)
Date: Tue, 10 May 2016 17:03:54 +0100
Subject: [PATCH 1/3] drm/rockchip: dw_hdmi: remove unused #include
In-Reply-To: <20160510160356.1167-1-john@metanate.com>
References: <20160510160356.1167-1-john@metanate.com>
Message-ID: <20160510160356.1167-2-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drm_encoder_slave is not used in this file.

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 801110f65a63..0665fb915579 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -15,7 +15,6 @@
 #include <drm/drmP.h>
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_edid.h>
-#include <drm/drm_encoder_slave.h>
 #include <drm/bridge/dw_hdmi.h>
 
 #include "rockchip_drm_drv.h"
-- 
2.8.2.565.gdb84f68.dirty
