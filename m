From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Fri, 26 Aug 2011 15:12:10 +0200
Subject: [PATCH 1/2] plarform-mx2-camera: fix missing header dma-mapping.h
Message-ID: <1314364331-4526-1-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 arch/arm/plat-mxc/devices/platform-mx2-camera.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/devices/platform-mx2-camera.c b/arch/arm/plat-mxc/devices/platform-mx2-camera.c
index b3f4828..a6199d7 100644
--- a/arch/arm/plat-mxc/devices/platform-mx2-camera.c
+++ b/arch/arm/plat-mxc/devices/platform-mx2-camera.c
@@ -6,6 +6,7 @@
  * the terms of the GNU General Public License version 2 as published by the
  * Free Software Foundation.
  */
+#include <linux/dma-mapping.h>
 #include <mach/hardware.h>
 #include <mach/devices-common.h>
 
-- 
1.7.5.4
