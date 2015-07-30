From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 30 Jul 2015 02:24:32 +0200
Subject: [PATCH 5/5] rtc: at91rm9200: sort headers alphabetically
In-Reply-To: <1438215872-27794-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1438215872-27794-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1438215872-27794-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sort included headers alphabetically.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-at91rm9200.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-at91rm9200.c b/drivers/rtc/rtc-at91rm9200.c
index 8093d9e50619..cb62e214b52a 100644
--- a/drivers/rtc/rtc-at91rm9200.c
+++ b/drivers/rtc/rtc-at91rm9200.c
@@ -18,21 +18,21 @@
  *
  */
 
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/time.h>
-#include <linux/rtc.h>
 #include <linux/bcd.h>
 #include <linux/clk.h>
+#include <linux/completion.h>
 #include <linux/interrupt.h>
-#include <linux/spinlock.h>
 #include <linux/ioctl.h>
-#include <linux/completion.h>
 #include <linux/io.h>
-#include <linux/of.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+#include <linux/spinlock.h>
 #include <linux/suspend.h>
+#include <linux/time.h>
 #include <linux/uaccess.h>
 
 #include "rtc-at91rm9200.h"
-- 
2.1.4
