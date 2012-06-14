From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 14 Jun 2012 13:59:43 +0800
Subject: [PATCH 12/16] i2c: imx: remove unneeded mach/irqs.h inclusion
In-Reply-To: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1339653587-4832-13-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove unneeded mach/irq.h inclusion from i2c-imx driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-i2c at vger.kernel.org
Cc: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/i2c/busses/i2c-imx.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 8d6b504..370031a 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -53,7 +53,6 @@
 #include <linux/of_i2c.h>
 #include <linux/pinctrl/consumer.h>
 
-#include <mach/irqs.h>
 #include <mach/hardware.h>
 #include <mach/i2c.h>
 
-- 
1.7.5.4
