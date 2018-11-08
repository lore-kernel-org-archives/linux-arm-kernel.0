From: brajeswar.linux@gmail.com (Brajeswar Ghosh)
Date: Thu, 8 Nov 2018 20:14:54 +0530
Subject: [PATCH] arm/mach-sa1100/hackkit.c: Remove duplicate header
Message-ID: <20181108144454.GA3797@hp-pavilion-15-notebook-pc-brajeswar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove linux/tty.h which is included more than once

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
---
 arch/arm/mach-sa1100/hackkit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index 643d5f2d9af9..0016d25e7deb 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -22,7 +22,6 @@
 #include <linux/serial_core.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include <linux/tty.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
-- 
2.17.1
