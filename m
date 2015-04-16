From: vivien.didelot@savoirfairelinux.com (Vivien Didelot)
Date: Thu, 16 Apr 2015 12:18:39 -0400
Subject: [PATCH] ARM: gemini: remove unnecessary mdio-gpio includes
Message-ID: <1429201119-32167-1-git-send-email-vivien.didelot@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the inclusion of linux/mdio-gpio.h in nas4220b, wbd111 and wbd222
boards since mdio-gpio is not used.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 arch/arm/mach-gemini/board-nas4220b.c | 1 -
 arch/arm/mach-gemini/board-wbd111.c   | 1 -
 arch/arm/mach-gemini/board-wbd222.c   | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/mach-gemini/board-nas4220b.c b/arch/arm/mach-gemini/board-nas4220b.c
index ca8a25b..18b1279 100644
--- a/arch/arm/mach-gemini/board-nas4220b.c
+++ b/arch/arm/mach-gemini/board-nas4220b.c
@@ -18,7 +18,6 @@
 #include <linux/leds.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
-#include <linux/mdio-gpio.h>
 #include <linux/io.h>
 
 #include <asm/setup.h>
diff --git a/arch/arm/mach-gemini/board-wbd111.c b/arch/arm/mach-gemini/board-wbd111.c
index 418188c..14c56f3 100644
--- a/arch/arm/mach-gemini/board-wbd111.c
+++ b/arch/arm/mach-gemini/board-wbd111.c
@@ -15,7 +15,6 @@
 #include <linux/input.h>
 #include <linux/skbuff.h>
 #include <linux/gpio_keys.h>
-#include <linux/mdio-gpio.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-gemini/board-wbd222.c b/arch/arm/mach-gemini/board-wbd222.c
index 266b265..6070282 100644
--- a/arch/arm/mach-gemini/board-wbd222.c
+++ b/arch/arm/mach-gemini/board-wbd222.c
@@ -15,7 +15,6 @@
 #include <linux/input.h>
 #include <linux/skbuff.h>
 #include <linux/gpio_keys.h>
-#include <linux/mdio-gpio.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <asm/mach-types.h>
-- 
2.3.5
