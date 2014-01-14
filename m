From: jg1.han@samsung.com (Jingoo Han)
Date: Tue, 14 Jan 2014 10:43:01 +0900
Subject: [PATCH] ARM: LPC32xx: common.c: Remove unnecessary header inclusion
Message-ID: <000101cf10c9$f602c000$e2084000$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

common.c includes some header files that are not really used.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
Compile-tested only.

 arch/arm/mach-lpc32xx/common.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
index d7aa54c..9713c8b 100644
--- a/arch/arm/mach-lpc32xx/common.c
+++ b/arch/arm/mach-lpc32xx/common.c
@@ -17,12 +17,6 @@
  */
 
 #include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/err.h>
-#include <linux/i2c.h>
-#include <linux/i2c-pnx.h>
 #include <linux/io.h>
 
 #include <asm/mach/map.h>
-- 
1.7.10.4
