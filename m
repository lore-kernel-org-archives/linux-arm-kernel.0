From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 25 Feb 2014 15:23:23 +0100
Subject: [RFC PATCH v4 8/8] staging: imx-drm: Update TODO
In-Reply-To: <1393338203-25051-1-git-send-email-p.zabel@pengutronix.de>
References: <1393338203-25051-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <1393338203-25051-9-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device tree bindings are updated regardless of the common display
framework and in the meantime the HDMI driver was included.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/TODO | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/imx-drm/TODO b/drivers/staging/imx-drm/TODO
index 6a9da94..29636fb 100644
--- a/drivers/staging/imx-drm/TODO
+++ b/drivers/staging/imx-drm/TODO
@@ -1,15 +1,10 @@
 TODO:
 - get DRM Maintainer review for this code
-- Wait for common display framework to hit mainline and update the IPU
-  driver to use it. This will most probably make changes to the devicetree
-  bindings necessary.
-- Factor out more code to common helper functions
 - decide where to put the base driver. It is not specific to a subsystem
   and would be used by DRM/KMS and media/V4L2
 
 Missing features (not necessarily for moving out of staging):
 
-- Add i.MX6 HDMI support
 - Add support for IC (Image converter)
 - Add support for CSI (CMOS Sensor interface)
 - Add support for VDIC (Video Deinterlacer)
-- 
1.8.5.3
