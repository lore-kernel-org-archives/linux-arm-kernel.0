From: danny.kukawka@bisect.de (Danny Kukawka)
Date: Thu, 16 Feb 2012 15:44:11 +0100
Subject: [PATCH] arch/arm/mach-vexpress/v2m.c: included linux/device.h twice
Message-ID: <1329403451-32383-1-git-send-email-danny.kukawka@bisect.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-vexpress/v2m.c: included 'linux/device.h' twice,
remove the duplicate.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 arch/arm/mach-vexpress/v2m.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-vexpress/v2m.c b/arch/arm/mach-vexpress/v2m.c
index b4a28ca..7725766 100644
--- a/arch/arm/mach-vexpress/v2m.c
+++ b/arch/arm/mach-vexpress/v2m.c
@@ -10,7 +10,6 @@
 #include <linux/ata_platform.h>
 #include <linux/smsc911x.h>
 #include <linux/spinlock.h>
-#include <linux/device.h>
 #include <linux/usb/isp1760.h>
 #include <linux/clkdev.h>
 #include <linux/mtd/physmap.h>
-- 
1.7.8.3
