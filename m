From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 6 Aug 2012 09:52:52 +0200
Subject: [PATCH] MAINTAINERS: update my entries
Message-ID: <1344239572-23250-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

I prefer to use the Linaro mail address for the MAINTAINERS
entry due to heavy mail traffic. Take this opportunity to
update the wildcards, including removing the stmpe* drivers
from the ux500 entry since these are not specific to that
machine.

Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Arnd, Olof: This is another patch I'd appreciate if you just
put into the fixes as a single thing.
---
 MAINTAINERS | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 94b823f..b694a9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -925,14 +925,14 @@ S:	Maintained
 
 ARM/NOMADIK ARCHITECTURE
 M:	Alessandro Rubini <rubini@unipv.it>
-M:	Linus Walleij <linus.walleij@stericsson.com>
+M:	Linus Walleij <linus.walleij@linaro.org>
 M:	STEricsson <STEricsson_nomadik_linux@list.st.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-nomadik/
 F:	arch/arm/plat-nomadik/
 F:	drivers/i2c/busses/i2c-nomadik.c
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
 
 ARM/OPENMOKO NEO FREERUNNER (GTA02) MACHINE SUPPORT
 M:	Nelson Castillo <arhuaco@freaks-unidos.net>
@@ -1146,7 +1146,7 @@ F:	drivers/usb/host/ehci-w90x900.c
 F:	drivers/video/nuc900fb.c
 
 ARM/U300 MACHINE SUPPORT
-M:	Linus Walleij <linus.walleij@stericsson.com>
+M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	arch/arm/mach-u300/
@@ -1161,15 +1161,20 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
 
 ARM/Ux500 ARM ARCHITECTURE
 M:	Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
-M:	Linus Walleij <linus.walleij@stericsson.com>
+M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-ux500/
+F:	drivers/clocksource/clksrc-dbx500-prcmu.c
 F:	drivers/dma/ste_dma40*
+F:	drivers/hwspinlock/u8500_hsem.c
 F:	drivers/mfd/abx500*
 F:	drivers/mfd/ab8500*
-F:	drivers/mfd/stmpe*
+F:	drivers/mfd/dbx500*
+F:	drivers/mfd/db8500*
+F:	drivers/pinctrl/pinctrl-nomadik*
 F:	drivers/rtc/rtc-ab8500.c
+F:	drivers/rtc/rtc-pl031.c
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
 
 ARM/VFP SUPPORT
@@ -3094,7 +3099,7 @@ F:	include/linux/gigaset_dev.h
 
 GPIO SUBSYSTEM
 M:	Grant Likely <grant.likely@secretlab.ca>
-M:	Linus Walleij <linus.walleij@stericsson.com>
+M:	Linus Walleij <linus.walleij@linaro.org>
 S:	Maintained
 T:	git git://git.secretlab.ca/git/linux-2.6.git
 F:	Documentation/gpio.txt
-- 
1.7.11.3
