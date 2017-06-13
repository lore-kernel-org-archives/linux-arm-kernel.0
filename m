From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 13 Jun 2017 14:58:42 +0200
Subject: [PATCH] mtd: nand: atmel_nand: drop unused include
Message-ID: <20170613125842.16422-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Atmel NAND driver doesn't used anything from
linux/platform_data/atmel.h, stop including it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/mtd/nand/atmel/nand-controller.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/atmel/nand-controller.c b/drivers/mtd/nand/atmel/nand-controller.c
index 3b2446896147..6bd61acfc2c8 100644
--- a/drivers/mtd/nand/atmel/nand-controller.c
+++ b/drivers/mtd/nand/atmel/nand-controller.c
@@ -64,7 +64,6 @@
 #include <linux/of_platform.h>
 #include <linux/iopoll.h>
 #include <linux/platform_device.h>
-#include <linux/platform_data/atmel.h>
 #include <linux/regmap.h>
 
 #include "pmecc.h"
-- 
2.11.0
