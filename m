From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 11 Mar 2014 22:57:53 +0800
Subject: [PATCH] MAINTAINERS: update IMX kernel git tree
Message-ID: <1394549873-18272-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change Shawn's email address to his employer, and move IMX git tree to
kernel.org.

Cc: Sascha Hauer <kernel@pengutronix.de>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 MAINTAINERS |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 85b3dd8..5663cb8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -910,11 +910,11 @@ F:	arch/arm/include/asm/hardware/dec21285.h
 F:	arch/arm/mach-footbridge/
 
 ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
-M:	Shawn Guo <shawn.guo@linaro.org>
+M:	Shawn Guo <shawn.guo@freescale.com>
 M:	Sascha Hauer <kernel@pengutronix.de>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-T:	git git://git.linaro.org/people/shawnguo/linux-2.6.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
 F:	arch/arm/mach-imx/
 F:	arch/arm/boot/dts/imx*
 F:	arch/arm/configs/imx*_defconfig
-- 
1.7.9.5
