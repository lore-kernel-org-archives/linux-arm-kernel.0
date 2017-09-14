From: hjc@rock-chips.com (Sandy Huang)
Date: Thu, 14 Sep 2017 11:43:28 +0800
Subject: [PATCH 3/3] drm/rockchip: vop: Add more RGB output interface type
In-Reply-To: <1505360594-196508-1-git-send-email-hjc@rock-chips.com>
References: <1505360594-196508-1-git-send-email-hjc@rock-chips.com>
Message-ID: <1505360608-377-1-git-send-email-hjc@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add serial RGB output interface for rockchip vop, the
more info about serial RGB output interface described at the
following file:

Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_vop.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
index 56bbd2e..59a01c3 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.h
@@ -209,6 +209,8 @@ struct vop_data {
 #define ROCKCHIP_OUT_MODE_P888	0
 #define ROCKCHIP_OUT_MODE_P666	1
 #define ROCKCHIP_OUT_MODE_P565	2
+#define ROCKCHIP_OUT_MODE_S888	8
+#define ROCKCHIP_OUT_MODE_S888_DUMMY	12
 /* for use special outface */
 #define ROCKCHIP_OUT_MODE_AAAA	15
 
-- 
2.7.4
