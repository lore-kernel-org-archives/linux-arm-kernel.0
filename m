From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 11 Apr 2013 11:04:21 +0200
Subject: [PATCH] staging: drm/imx: update TODO file
In-Reply-To: <20130409231523.GA15722@kroah.com>
References: <20130409231523.GA15722@kroah.com>
Message-ID: <1365671061-10486-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

One of the main things to do to the driver is to support
the common display famework (CDF) to hit mainline. As this will
make some changes to the devicetree bindings necessary it makes
sense to do it before we move out of staging.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/staging/imx-drm/TODO | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/imx-drm/TODO b/drivers/staging/imx-drm/TODO
index e52adc4..123acbe 100644
--- a/drivers/staging/imx-drm/TODO
+++ b/drivers/staging/imx-drm/TODO
@@ -1,5 +1,8 @@
 TODO:
 - get DRM Maintainer review for this code
+- Wait for common display framework to hit mainline and update the IPU
+  driver to use it. This will most probably make changes to the devicetree
+  bindings necessary.
 - Factor out more code to common helper functions
 - decide where to put the base driver. It is not specific to a subsystem
   and would be used by DRM/KMS and media/V4L2
-- 
1.8.2.rc2
