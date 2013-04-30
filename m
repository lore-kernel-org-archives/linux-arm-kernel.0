From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Tue, 30 Apr 2013 16:58:00 -0700
Subject: [PATCH 3/7] clocksource/cadence_ttc: Sort #includes alphabetically
In-Reply-To: <1367366284-28304-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1367366284-28304-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1367366284-28304-4-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/clocksource/cadence_ttc_timer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/cadence_ttc_timer.c b/drivers/clocksource/cadence_ttc_timer.c
index 685bc60..ab8fc2c 100644
--- a/drivers/clocksource/cadence_ttc_timer.c
+++ b/drivers/clocksource/cadence_ttc_timer.c
@@ -16,12 +16,12 @@
  */
 
 #include <linux/clk.h>
-#include <linux/interrupt.h>
+#include <linux/clk-provider.h>
 #include <linux/clockchips.h>
+#include <linux/interrupt.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/slab.h>
-#include <linux/clk-provider.h>
 
 /*
  * This driver configures the 2 16-bit count-up timers as follows:
-- 
1.8.2.2
