From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 11 Feb 2012 09:24:51 -0800
Subject: [PATCH] MAINTAINERS: Update ARM/FREESCALE IMX entry
Message-ID: <1328981091-12296-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With arch/arm/mach-mx5 merged into arch/arm/mach-imx, it may be
reasonable to make the following two changes.

* Remove 'arch/arm/mach-mx*/' from entry 'ARM/FREESCALE IMX entry',
  since mach-mx5 has gone into mach-imx and mach-mxs already gets
  another separate entry, which means mach-mx* only stands for mach-imx
  anyway.

* Remove entry 'ARM/FREESCALE IMX51' completely, since mach-mx5 has
  gone and it seems that Amit Kucheria has lost the interest in
  maintaining IMX51 for some time.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Amit Kucheria <amit.kucheria@canonical.com>
Cc: Sascha Hauer <kernel@pengutronix.de>
---
 MAINTAINERS |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a1fce9a..f0946a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -785,16 +785,9 @@ M:	Sascha Hauer <kernel@pengutronix.de>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 T:	git git://git.pengutronix.de/git/imx/linux-2.6.git
-F:	arch/arm/mach-mx*/
 F:	arch/arm/mach-imx/
 F:	arch/arm/plat-mxc/
 
-ARM/FREESCALE IMX51
-M:	Amit Kucheria <amit.kucheria@canonical.com>
-L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
-F:	arch/arm/mach-mx5/
-
 ARM/FREESCALE IMX6
 M:	Shawn Guo <shawn.guo@linaro.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
-- 
1.7.5.4
