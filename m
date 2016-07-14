From: mark.yao@rock-chips.com (Mark Yao)
Date: Thu, 14 Jul 2016 11:31:25 +0800
Subject: [PATCH 1/6] drm/rockchip: dw_hdmi: remove unused #include
In-Reply-To: <1468467090-6108-1-git-send-email-mark.yao@rock-chips.com>
References: <1468467090-6108-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <1468467090-6108-2-git-send-email-mark.yao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: John Keeping <john@metanate.com>

drm_encoder_slave is not used in this file.

Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 801110f..0665fb9 100644
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
1.9.1
