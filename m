From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri,  6 Mar 2015 13:52:58 +0100
Subject: [PATCH] ARM: mediatek: enable the pin controller
Message-ID: <1425646378-3703-1-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the pin controller for Mediatek SoCs.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm/mach-mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index f7e463c..9f59e58 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -1,6 +1,7 @@
 menuconfig ARCH_MEDIATEK
 	bool "Mediatek MT65xx & MT81xx SoC" if ARCH_MULTI_V7
 	select ARM_GIC
+	select PINCTRL
 	select MTK_TIMER
 	help
 	  Support for Mediatek MT65xx & MT81xx SoCs
-- 
1.9.1
