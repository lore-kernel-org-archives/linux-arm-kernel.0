From: linus.walleij@stericsson.com (Linus Walleij)
Date: Sun,  4 Apr 2010 00:46:45 +0200
Subject: [PATCH] ARM: add MAINTAINERS for U300
Message-ID: <1270334805-20767-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus@foobar.localdomain>

This adds myself as maintainer of the U300 machine and associated
system-on-chip drivers.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 MAINTAINERS |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d29fa3..6eb978e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -971,6 +971,16 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 W:	http://www.mcuos.com
 S:	Maintained
 
+ARM/U300 MACHINE SUPPORT
+M:	Linus Walleij <linus.walleij@stericsson.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	arch/arm/mach-u300/
+F:	drivers/i2c/busses/i2c-stu300.c
+F:	drivers/rtc/rtc-coh901331.c
+F:	drivers/watchdog/coh901327_wdt.c
+F:	drivers/dma/coh901318*
+
 ARM/U8500 ARM ARCHITECTURE
 M:	Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
1.6.6.1
