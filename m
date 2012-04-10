From: thomas@tomweber.eu (Thomas Weber)
Date: Tue, 10 Apr 2012 15:11:01 +0200
Subject: [PATCH] ARM:vexpress: Remove twice included header files
Message-ID: <1334063461-11130-1-git-send-email-thomas@tomweber.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove duplicates of
 - linux/device.h and
 - asm/hardware/gic.h

Signed-off-by: Thomas Weber <thomas@tomweber.eu>
---
 arch/arm/mach-vexpress/v2m.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index 47cdcca..e769ab6 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -14,7 +14,6 @@
 #include <linux/ata_platform.h>
 #include <linux/smsc911x.h>
 #include <linux/spinlock.h>
-#include <linux/device.h>
 #include <linux/usb/isp1760.h>
 #include <linux/clkdev.h>
 #include <linux/mtd/physmap.h>
@@ -29,7 +28,6 @@
 #include <asm/hardware/gic.h>
 #include <asm/hardware/timer-sp.h>
 #include <asm/hardware/sp810.h>
-#include <asm/hardware/gic.h>
 
 #include <mach/ct-ca9x4.h>
 #include <mach/motherboard.h>
-- 
1.7.10
