From: jianwei.wang.chn@gmail.com (Jianwei Wang)
Date: Fri, 24 Jul 2015 18:34:14 +0800
Subject: [PATCH v12 6/6] MAINTAINERS: add Freescale DCU DRM driver maintainer
In-Reply-To: <1437734054-36163-1-git-send-email-jianwei.wang.chn@gmail.com>
References: <1437734054-36163-1-git-send-email-jianwei.wang.chn@gmail.com>
Message-ID: <1437734054-36163-7-git-send-email-jianwei.wang.chn@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Alison and myself as maintainers of the Freescale DCU DRM driver.

Signed-off-by: Alison Wang <b18965@freescale.com>
Signed-off-by: Xiubo Li <lixiubo@cmss.chinamobile.com>
Signed-off-by: Jianwei Wang <jianwei.wang.chn@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6761318..387a84a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3397,6 +3397,15 @@ F:	drivers/gpu/drm/exynos/
 F:	include/drm/exynos*
 F:	include/uapi/drm/exynos*
 
+DRM DRIVERS FOR FREESCALE DCU
+M:	Jianwei Wang <jianwei.wang.chn@gmail.com>
+M:	Alison Wang <alison.wang@freescale.com>
+L:	dri-devel at lists.freedesktop.org
+S:	Supported
+F:	drivers/gpu/drm/fsl-dcu/
+F:	Documentation/devicetree/bindings/video/fsl,dcu.txt
+F:	Documentation/devicetree/bindings/panel/nec,nl4827hc19_05b.txt
+
 DRM DRIVERS FOR FREESCALE IMX
 M:	Philipp Zabel <p.zabel@pengutronix.de>
 L:	dri-devel at lists.freedesktop.org
-- 
2.1.0.27.g96db324
