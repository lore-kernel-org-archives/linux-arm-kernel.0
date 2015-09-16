From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Wed, 16 Sep 2015 10:04:54 +0800
Subject: [PATCH 1/2] arm64: mediatek: enable MTK_TIMER
Message-ID: <1442369095-1094-1-git-send-email-yingjoe.chen@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable MTK_TIMER for MediaTek plaform, which will be used as
schedule clock.

Change-Id: Ib77a0bf01193102c755077b6e72e73e477b18e5f
Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 23800a1..8176455 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -42,6 +42,7 @@ config ARCH_MEDIATEK
 	bool "Mediatek MT65xx & MT81xx ARMv8 SoC"
 	select ARM_GIC
 	select PINCTRL
+	select MTK_TIMER
 	help
 	  Support for Mediatek MT65xx & MT81xx ARMv8 SoCs
 
-- 
1.9.1
