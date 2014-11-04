From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Tue, 4 Nov 2014 15:30:55 +0800
Subject: [PATCH v5 8/8] ARM: mediatek: Fix description for mediatek SoCs
In-Reply-To: <1415086255-5555-1-git-send-email-yingjoe.chen@mediatek.com>
References: <1415086255-5555-1-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <1415086255-5555-9-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Joe.C" <yingjoe.chen@mediatek.com>

We support more MediaTek SoCs now, update the description.

Signed-off-by: Joe.C <yingjoe.chen@mediatek.com>
---
 arch/arm/mach-mediatek/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 2c043a2..f73f588 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -1,6 +1,6 @@
 config ARCH_MEDIATEK
-	bool "Mediatek MT6589 SoC" if ARCH_MULTI_V7
+	bool "Mediatek MT65xx & MT81xx SoC" if ARCH_MULTI_V7
 	select ARM_GIC
 	select MTK_TIMER
 	help
-	  Support for Mediatek Cortex-A7 Quad-Core-SoC MT6589.
+	  Support for Mediatek MT65xx & MT81xx SoCs
-- 
1.8.1.1.dirty
