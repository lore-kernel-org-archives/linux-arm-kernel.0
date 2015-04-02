From: festevam@gmail.com (Fabio Estevam)
Date: Thu,  2 Apr 2015 09:25:44 -0300
Subject: [PATCH] ARM: dts: Makefile: Fix alpine dtb name
Message-ID: <1427977544-11420-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The name of the dts file is alpine-db.dts, so fix it in the Makefile.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 1647e40..c6e95ab 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1,7 +1,7 @@
 ifeq ($(CONFIG_OF),y)
 
 dtb-$(CONFIG_ARCH_ALPINE) += \
-	alpine_db.dtb
+	alpine-db.dtb
 dtb-$(CONFIG_MACH_ASM9260) += \
 	alphascale-asm9260-devkit.dtb
 # Keep at91 dtb files sorted alphabetically for each SoC
-- 
1.9.1
