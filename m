From: mcuos.com@gmail.com (Wan ZongShun)
Date: Sun, 16 May 2010 23:58:24 +0800
Subject: [PATCH] MAINTAINERS: Add Files and directories entry for NUC900
	platform
Message-ID: <4BF01620.6000708@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russell,

I want to add MAINTIANERS Files and directories of mine,
Can I submit the patch to your mail list for this?

Thanks!

Signed-off-by: Wan ZongShun<mcuos.com@gmail.com>

---
 MAINTAINERS |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1838875..6861818 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -970,6 +970,16 @@ M:	Wan ZongShun <mcuos.com@gmail.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 W:	http://www.mcuos.com
 S:	Maintained
+F:	arch/arm/mach-w90x900/
+F:	arch/arm/mach-nuc93x/
+F:	drivers/input/keyboard/w90p910_keypad.c
+F:	drivers/input/touchscreen/w90p910_ts.c
+F:	drivers/watchdog/nuc900_wdt.c
+F:	drivers/net/arm/w90p910_ether.c
+F:	drivers/mtd/nand/w90p910_nand.c
+F:	drivers/rtc/rtc-nuc900.c
+F:	drivers/spi/spi_nuc900.c
+F:	drivers/usb/host/ehci-w90x900.c

 ARM/U300 MACHINE SUPPORT
 M:	Linus Walleij <linus.walleij@stericsson.com>
-- 
1.6.3.3
