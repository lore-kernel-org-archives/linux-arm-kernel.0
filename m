From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 17 Jul 2015 22:53:26 +0200
Subject: [PATCH] ARM: mediatek: Add regmap to mediatek Kconfig
Message-ID: <1437166406-14233-1-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mediatek SoC needs the regmap/syscon infrastructure.
The infrastructure is used by the clock and pinctrl driver.
This patch adds MD_SYSCON to Kconfig for all Mediatek devices.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm/mach-mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 9f59e58..aeece17 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -3,6 +3,7 @@ menuconfig ARCH_MEDIATEK
 	select ARM_GIC
 	select PINCTRL
 	select MTK_TIMER
+	select MFD_SYSCON
 	help
 	  Support for Mediatek MT65xx & MT81xx SoCs
 
-- 
1.9.1
