From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 19 May 2017 18:04:48 +0200
Subject: [PATCH 6/9] arm64: marvell: enable the Armada 7K/8K pinctrl driver
In-Reply-To: <cover.0dd8a92ae74fcec8d0470d0a7016035089e46eed.1495209664.git-series.gregory.clement@free-electrons.com>
References: <cover.0dd8a92ae74fcec8d0470d0a7016035089e46eed.1495209664.git-series.gregory.clement@free-electrons.com>
Message-ID: <26849468b738ebe13968d31997f944018ea9ff23.1495209664.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit makes sure the drivers for the Armada 7K/8K pin controllers
are enabled.

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/Kconfig.platforms | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 4afcffcb46cb..e73b3b007e04 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -108,6 +108,8 @@ config ARCH_MVEBU
 	select ARMADA_37XX_CLK
 	select MVEBU_ODMI
 	select MVEBU_PIC
+	select PINCTRL_ARMADA_AP806
+	select PINCTRL_ARMADA_CP110
 	help
 	  This enables support for Marvell EBU familly, including:
 	   - Armada 3700 SoC Family
-- 
git-series 0.9.1
