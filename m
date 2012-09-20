From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 20 Sep 2012 14:45:27 +0800
Subject: [PATCH v2 14/34] dma: imx-sdma: remove unneeded mach/hardware.h
 inclusion
In-Reply-To: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1348123547-31082-15-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The inclusion of mach/hardware.h is not used in imx-sdma driver at all.
Remove it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Cc: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/imx-sdma.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 1b781d6..38edf46 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -40,7 +40,6 @@
 #include <asm/irq.h>
 #include <linux/platform_data/dma-imx-sdma.h>
 #include <linux/platform_data/dma-imx.h>
-#include <mach/hardware.h>
 
 #include "dmaengine.h"
 
-- 
1.7.9.5
