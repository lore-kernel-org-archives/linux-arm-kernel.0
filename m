From: xuwei5@hisilicon.com (xuwei)
Date: Fri, 4 Jul 2014 15:11:19 +0800
Subject: [PATCH] MAINTAINERS:ARM:hisi: add Hisilicon SoC family
Message-ID: <53B65397.40108@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Introduce a new mach-hisi that will support Hisilicon SoCs based on ARMv7
and I am taking maintainership for it.

Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 134483f..c11c89b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -972,6 +972,14 @@ F:	arch/arm/mach-pxa/hx4700.c
 F:	arch/arm/mach-pxa/include/mach/hx4700.h
 F:	sound/soc/pxa/hx4700.c
 
+ARM/Hisilicon SoC support
+M:	Wei Xu <xuwei5@hisilicon.com>
+L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
+W:	www.hisilicon.com
+S:	Maintained
+T:	git git://github.com/hisilicon/linux-hisi.git
+F:	arch/arm/mach-hisi/
+
 ARM/HP JORNADA 7XX MACHINE SUPPORT
 M:	Kristoffer Ericson <kristoffer.ericson@gmail.com>
 W:	www.jlime.com
-- 
1.8.1.2
