From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 18 Dec 2017 17:39:19 +0800
Subject: [PATCH] ARM: mediatek: use more generic prompts for SoCs with ARMv7
Message-ID: <e118518cb3ab8bf0ae45669b003153dc1a49ba2f.1513589301.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Supported MediaTek SoCs with ARMv7 are not limited within MT65xx or MT81xx
and thus use more generic words to prompt users as the other vendors
usually use.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/mach-mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 70e49d5..91cc461 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -1,5 +1,5 @@
 menuconfig ARCH_MEDIATEK
-	bool "Mediatek MT65xx & MT81xx SoC"
+	bool "MediaTek SoC Support"
 	depends on ARCH_MULTI_V7
 	select ARM_GIC
 	select PINCTRL
-- 
2.7.4
