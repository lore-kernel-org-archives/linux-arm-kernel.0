From: hayashibara.keiji@socionext.com (Keiji Hayashibara)
Date: Thu,  2 Aug 2018 13:42:43 +0900
Subject: [PATCH] spi: uniphier: remove unnecessary include headers
Message-ID: <1533184963-28508-1-git-send-email-hayashibara.keiji@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit removed include headers of linux/of.h and linux/of_platform.h,
because they are not used.

Signed-off-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
---
 drivers/spi/spi-uniphier.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
index 0899854..5a6137f 100644
--- a/drivers/spi/spi-uniphier.c
+++ b/drivers/spi/spi-uniphier.c
@@ -10,8 +10,6 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 
-- 
2.7.4
