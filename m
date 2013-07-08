From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon,  8 Jul 2013 09:51:37 -0700
Subject: [PATCH v2 1/2] clocksource/cadence_ttc: Remove unused header
In-Reply-To: <1373302298-27957-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1373302298-27957-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1373302298-27957-2-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk-provider.h header is not required by this driver.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/clocksource/cadence_ttc_timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/cadence_ttc_timer.c
index 4cbe28c..0eefc8d 100644
--- a/drivers/clocksource/cadence_ttc_timer.c
+++ b/drivers/clocksource/cadence_ttc_timer.c
@@ -21,7 +21,6 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/slab.h>
-#include <linux/clk-provider.h>
 
 /*
  * This driver configures the 2 16-bit count-up timers as follows:
-- 
1.8.3.2
