From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 10 Aug 2015 16:33:40 +0200
Subject: [PATCH 2/2] rtc: at91sam9: remove useless include
In-Reply-To: <1439217220-13561-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1439217220-13561-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1439217220-13561-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Definitions from linux/platform_data/atmel.h are not used, remove the
include.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/rtc/rtc-at91sam9.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-at91sam9.c b/drivers/rtc/rtc-at91sam9.c
index 9f6c3631b8d5..7ef30221812c 100644
--- a/drivers/rtc/rtc-at91sam9.c
+++ b/drivers/rtc/rtc-at91sam9.c
@@ -19,7 +19,6 @@
 #include <linux/interrupt.h>
 #include <linux/ioctl.h>
 #include <linux/slab.h>
-#include <linux/platform_data/atmel.h>
 #include <linux/io.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
-- 
2.1.4
