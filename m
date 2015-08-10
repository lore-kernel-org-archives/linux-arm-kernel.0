From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 10 Aug 2015 16:33:39 +0200
Subject: [PATCH 1/2] rtc: at91sam9: include linux/of.h
Message-ID: <1439217220-13561-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver is using device tree but is not including of.h

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-at91sam9.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 5ccaee32df72..9f6c3631b8d5 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -25,6 +25,7 @@
 #include <linux/regmap.h>
 #include <linux/suspend.h>
 #include <linux/clk.h>
+#include <linux/of.h>
 
 /*
  * This driver uses two configurable hardware resources that live in the
-- 
2.1.4
