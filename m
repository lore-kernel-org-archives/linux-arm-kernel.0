From: baruch@tkos.co.il (Baruch Siach)
Date: Mon,  9 Mar 2015 11:05:14 +0200
Subject: [PATCH] ARM: digicolor: add the machine directory to Makefile
Message-ID: <286ee8cf58a31417f28f22e071023ad29d161df8.1425891914.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the digicolor specific DT_MACHINE_START entry visible.

Fixes: df8d742e929 (ARM: initial support for Conexant Digicolor CX92755 SoC)
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 7f99cd652203..eb7bb511f853 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -150,6 +150,7 @@ machine-$(CONFIG_ARCH_BERLIN)		+= berlin
 machine-$(CONFIG_ARCH_CLPS711X)		+= clps711x
 machine-$(CONFIG_ARCH_CNS3XXX)		+= cns3xxx
 machine-$(CONFIG_ARCH_DAVINCI)		+= davinci
+machine-$(CONFIG_ARCH_DIGICOLOR)	+= digicolor
 machine-$(CONFIG_ARCH_DOVE)		+= dove
 machine-$(CONFIG_ARCH_EBSA110)		+= ebsa110
 machine-$(CONFIG_ARCH_EFM32)		+= efm32
-- 
2.1.4
