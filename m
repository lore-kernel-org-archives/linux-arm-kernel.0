From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Sep 2012 13:34:44 +0800
Subject: [PATCH 15/34] dma: imx-sdma: remove unneeded mach/hardware.h inclusion
In-Reply-To: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1347860103-4141-16-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The inclusion of mach/hardware.h is not used in imx-sdma driver at all.
Remove it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
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
