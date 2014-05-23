From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 23 May 2014 12:30:59 +0200
Subject: [PATCH 19/71] clocksource: sh_cmt: Sort headers alphabetically
In-Reply-To: <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
References: <537F214C.8000700@linaro.org>
 <1400841111-6683-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1400841111-6683-19-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

This helps locating duplicates and inserting new headers.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_cmt.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 399e952..9f215e7 100644
--- a/drivers/clocksource/sh_cmt.c
+++ b/drivers/clocksource/sh_cmt.c
@@ -13,23 +13,23 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/delay.h>
+#include <linux/err.h>
 #include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/spinlock.h>
 #include <linux/interrupt.h>
-#include <linux/ioport.h>
 #include <linux/io.h>
-#include <linux/clk.h>
+#include <linux/ioport.h>
 #include <linux/irq.h>
-#include <linux/err.h>
-#include <linux/delay.h>
-#include <linux/clocksource.h>
-#include <linux/clockchips.h>
-#include <linux/sh_timer.h>
-#include <linux/slab.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
+#include <linux/sh_timer.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
 
 struct sh_cmt_device;
 
-- 
1.7.9.5
