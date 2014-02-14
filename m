From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Fri, 14 Feb 2014 01:59:52 +0100
Subject: [PATCH 14/27] clocksource: sh_cmt: Sort headers alphabetically
In-Reply-To: <1392339605-20691-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1392339605-20691-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1392339605-20691-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This helps locating duplicates and inserting new headers.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/clocksource/sh_cmt.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/clocksource/sh_cmt.c b/drivers/clocksource/sh_cmt.c
index 9f5616b..077879b 100644
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
1.8.3.2
