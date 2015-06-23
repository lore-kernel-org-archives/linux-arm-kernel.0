From: nm@ti.com (Nishanth Menon)
Date: Tue, 23 Jun 2015 11:15:12 -0500
Subject: [PATCH V2 3/5] drivers/rtc/rtc-ds1307.c: Sort the headers
In-Reply-To: <1435076114-12416-1-git-send-email-nm@ti.com>
References: <1435076114-12416-1-git-send-email-nm@ti.com>
Message-ID: <1435076114-12416-4-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is always a good practice to keep the #includes sorted

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/rtc/rtc-ds1307.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 0a98d8a52791..b03880fc32b5 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -11,14 +11,14 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/module.h>
+#include <linux/bcd.h>
+#include <linux/i2c.h>
 #include <linux/init.h>
+#include <linux/module.h>
+#include <linux/rtc/ds1307.h>
+#include <linux/rtc.h>
 #include <linux/slab.h>
-#include <linux/i2c.h>
 #include <linux/string.h>
-#include <linux/rtc.h>
-#include <linux/bcd.h>
-#include <linux/rtc/ds1307.h>
 
 /*
  * We can't determine type by probing, but if we expect pre-Linux code
-- 
1.7.9.5
