From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Sun, 25 Oct 2009 00:30:55 +0400
Subject: [PATCH 17/20] SA1100: h3100/h3600: clean up #includes
In-Reply-To: <1256415979-22930-1-git-send-email-mad_soft@inbox.ru>
References: <1256415979-22930-1-git-send-email-mad_soft@inbox.ru>
Message-ID: <1256416257-23003-1-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After a code reorganization and following split, there's some #includes
now unused. Clean them up and sort remaining alphabetticaly where possible.

Compile tested.

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 arch/arm/mach-sa1100/h3100.c |   17 -----------------
 arch/arm/mach-sa1100/h3600.c |   17 -----------------
 arch/arm/mach-sa1100/h3xxx.c |   17 ++---------------
 3 files changed, 2 insertions(+), 49 deletions(-)

diff --git a/arch/arm/mach-sa1100/h3100.c b/arch/arm/mach-sa1100/h3100.c
index 303bcd1..793e68c 100644
--- a/arch/arm/mach-sa1100/h3100.c
+++ b/arch/arm/mach-sa1100/h3100.c
@@ -10,30 +10,13 @@
  *
  */
 
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/tty.h>
-#include <linux/pm.h>
-#include <linux/device.h>
-#include <linux/mfd/htc-egpio.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/partitions.h>
-#include <linux/serial_core.h>
 #include <linux/gpio.h>
-#include <linux/platform_device.h>
 
-#include <asm/irq.h>
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
-#include <asm/setup.h>
-
-#include <asm/mach/irq.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/flash.h>
 #include <asm/mach/irda.h>
-#include <asm/mach/map.h>
-#include <asm/mach/serial_sa1100.h>
 
 #include <mach/h3xxx.h>
 
diff --git a/arch/arm/mach-sa1100/h3600.c b/arch/arm/mach-sa1100/h3600.c
index 25f189b..47587cc 100644
--- a/arch/arm/mach-sa1100/h3600.c
+++ b/arch/arm/mach-sa1100/h3600.c
@@ -10,30 +10,13 @@
  *
  */
 
-#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/tty.h>
-#include <linux/pm.h>
-#include <linux/device.h>
-#include <linux/mfd/htc-egpio.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/partitions.h>
-#include <linux/serial_core.h>
 #include <linux/gpio.h>
-#include <linux/platform_device.h>
 
-#include <asm/irq.h>
-#include <mach/hardware.h>
 #include <asm/mach-types.h>
-#include <asm/setup.h>
-
-#include <asm/mach/irq.h>
 #include <asm/mach/arch.h>
-#include <asm/mach/flash.h>
 #include <asm/mach/irda.h>
-#include <asm/mach/map.h>
-#include <asm/mach/serial_sa1100.h>
 
 #include <mach/h3xxx.h>
 
diff --git a/arch/arm/mach-sa1100/h3xxx.c b/arch/arm/mach-sa1100/h3xxx.c
index c9ef056..2f85d1d 100644
--- a/arch/arm/mach-sa1100/h3xxx.c
+++ b/arch/arm/mach-sa1100/h3xxx.c
@@ -10,28 +10,15 @@
  *
  */
 
-#include <linux/module.h>
-#include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/tty.h>
-#include <linux/pm.h>
-#include <linux/device.h>
+#include <linux/gpio.h>
 #include <linux/mfd/htc-egpio.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include <linux/serial_core.h>
-#include <linux/gpio.h>
 #include <linux/platform_device.h>
+#include <linux/serial_core.h>
 
-#include <asm/irq.h>
-#include <mach/hardware.h>
-#include <asm/mach-types.h>
-#include <asm/setup.h>
-
-#include <asm/mach/irq.h>
-#include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
-#include <asm/mach/irda.h>
 #include <asm/mach/map.h>
 #include <asm/mach/serial_sa1100.h>
 
-- 
1.6.5.1.63.ga9d7.dirty
