From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sun, 22 Jun 2014 16:06:22 -0400
Subject: [PATCH] MAINTAINERS: Add few more Keystone drivers
Message-ID: <1403467582-7933-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update MAINTAINERS file for recently added reset controller, AEMIF
and clocksource driver for Keystone SOCs.

The EMIF memory controller driver is also added along with AEMIF.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 MAINTAINERS |   26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f2e171..ae6d967 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1052,9 +1052,33 @@ M:	Santosh Shilimkar <santosh.shilimkar@ti.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-keystone/
-F:	drivers/clk/keystone/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
 
+ARM/TEXAS INSTRUMENT KEYSTONE CLOCK FRAMEWORK
+M:	Santosh Shilimkar <santosh.shilimkar@ti.com>
+L:	linux-kernel at vger.kernel.org
+S:	Maintained
+F:	drivers/clk/keystone/
+
+ARM/TEXAS INSTRUMENT KEYSTONE ClOCKSOURCE
+M:	Santosh Shilimkar <santosh.shilimkar@ti.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+L:	linux-kernel at vger.kernel.org
+S:	Maintained
+F:	drivers/clocksource/timer-keystone.c
+
+ARM/TEXAS INSTRUMENT KEYSTONE RESET DRIVER
+M:	Santosh Shilimkar <santosh.shilimkar@ti.com>
+L:	linux-kernel at vger.kernel.org
+S:	Maintained
+F:	drivers/power/reset/keystone-reset.c
+
+ARM/TEXAS INSTRUMENT AEMIF/EMIF DRIVERS
+M:	Santosh Shilimkar <santosh.shilimkar@ti.com>
+L:	linux-kernel at vger.kernel.org
+S:	Maintained
+F:	drivers/memory/*emif*
+
 ARM/LOGICPD PXA270 MACHINE SUPPORT
 M:	Lennert Buytenhek <kernel@wantstofly.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
1.7.9.5
