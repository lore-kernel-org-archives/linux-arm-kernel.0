From: ck.hu@mediatek.com (CK Hu)
Date: Fri, 15 Jul 2016 13:52:04 +0800
Subject: [PATCH] drm: mediatek: add Maintainers entry for Mediatek DRM drivers
Message-ID: <1468561924-45582-1-git-send-email-ck.hu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CK Hu and Philipp Zabel as maintainers for Mediatek DRM drivers.

Signed-off-by: CK Hu <ck.hu@mediatek.com>
---
 MAINTAINERS |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7304d2e..2a04cdc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3973,6 +3973,14 @@ S:	Orphan / Obsolete
 F:	drivers/gpu/drm/i810/
 F:	include/uapi/drm/i810_drm.h
 
+DRM DRIVERS FOR MEDIATEK
+M:	CK Hu <ck.hu@mediatek.com>
+M:	Philipp Zabel <p.zabel@pengutronix.de>
+L:	dri-devel at lists.freedesktop.org
+S:	Supported
+F:	drivers/gpu/drm/mediatek/
+F:	Documentation/devicetree/bindings/display/mediatek/
+
 DRM DRIVER FOR MSM ADRENO GPU
 M:	Rob Clark <robdclark@gmail.com>
 L:	linux-arm-msm at vger.kernel.org
-- 
1.7.9.5
