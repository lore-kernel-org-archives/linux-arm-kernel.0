From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 30 Jul 2015 02:24:30 +0200
Subject: [PATCH 3/5] rtc: at91sam9: sort headers alphabetically
In-Reply-To: <1438215872-27794-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438215872-27794-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438215872-27794-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort included headers alphabetically.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-at91sam9.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 0a8485ac3864..23f721d049b2 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -11,20 +11,20 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/time.h>
-#include <linux/rtc.h>
+#include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/ioctl.h>
-#include <linux/slab.h>
-#include <linux/platform_data/atmel.h>
 #include <linux/io.h>
+#include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/platform_data/atmel.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/rtc.h>
+#include <linux/slab.h>
 #include <linux/suspend.h>
-#include <linux/clk.h>
+#include <linux/time.h>
 
 /*
  * This driver uses two configurable hardware resources that live in the
-- 
2.1.4
