From: tony@atomide.com (Tony Lindgren)
Date: Thu,  5 Jan 2017 13:41:01 -0800
Subject: [PATCH] MAINTAINERS: Add Aaro Koskinen as TI omap1 SoC co-maintainer
Message-ID: <20170105214101.30286-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aaro has been doing a great job making sure mach-omap1 stays working
with the mainline kernel. So let's add Aaro as omap1 co-maintainer to
the MAINTAINERS file.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 MAINTAINERS | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8933,7 +8933,20 @@ M:	Josh Poimboeuf <jpoimboe@redhat.com>
 S:	Supported
 F:	tools/objtool/
 
-OMAP SUPPORT
+OMAP1 SUPPORT
+M:	Aaro Koskinen <aaro.koskinen@iki.fi>
+M:	Tony Lindgren <tony@atomide.com>
+L:	linux-omap at vger.kernel.org
+Q:	http://patchwork.kernel.org/project/linux-omap/list/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
+S:	Maintained
+F:	arch/arm/mach-omap1/
+F:	arch/arm/plat-omap/
+F:	arch/arm/configs/omap1_defconfig
+F:	drivers/i2c/busses/i2c-omap.c
+F:	include/linux/i2c-omap.h
+
+OMAP2+ SUPPORT
 M:	Tony Lindgren <tony@atomide.com>
 L:	linux-omap at vger.kernel.org
 W:	http://www.muru.com/linux/omap/
@@ -8941,8 +8954,8 @@ W:	http://linux.omap.com/
 Q:	http://patchwork.kernel.org/project/linux-omap/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
 S:	Maintained
-F:	arch/arm/*omap*/
-F:	arch/arm/configs/omap1_defconfig
+F:	arch/arm/mach-omap2/
+F:	arch/arm/plat-omap/
 F:	arch/arm/configs/omap2plus_defconfig
 F:	drivers/i2c/busses/i2c-omap.c
 F:	drivers/irqchip/irq-omap-intc.c
-- 
2.11.0
