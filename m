From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 19 Oct 2017 17:52:54 +0800
Subject: [PATCH] arm64: mediatek: cleanup message for platform selection
Message-ID: <82b4e4301bb762af59fd76cfe15f0a5773c78bb3.1508406417.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

The latest kernel tree already can support more MediaTek platforms such as
MT2712 and MT7622, so additional descriptions for those platforms are added
and certain cleanups are also being made here.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm64/Kconfig.platforms | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 6b54ee8..ab69f5f 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -91,12 +91,13 @@ config ARCH_HISI
 	  This enables support for Hisilicon ARMv8 SoC family
 
 config ARCH_MEDIATEK
-	bool "Mediatek MT65xx & MT81xx ARMv8 SoC"
+	bool "MediaTek SoC Family"
 	select ARM_GIC
 	select PINCTRL
 	select MTK_TIMER
 	help
-	  Support for Mediatek MT65xx & MT81xx ARMv8 SoCs
+	  This enables support for MediaTek MT27xx, MT65xx, MT76xx
+	  & MT81xx ARMv8 SoCs
 
 config ARCH_MESON
 	bool "Amlogic Platforms"
-- 
2.7.4
