From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 21 Mar 2017 19:28:31 +0100
Subject: [PATCH v2 2/7] arm64: marvell: enable the Armada 37xx pinctrl driver
In-Reply-To: <cover.26288667a039bc9f8e62dec2fd6342ded4014d12.1490120798.git-series.gregory.clement@free-electrons.com>
References: <cover.26288667a039bc9f8e62dec2fd6342ded4014d12.1490120798.git-series.gregory.clement@free-electrons.com>
Message-ID: <7e960e875235ed2acf9e28aeee0bdeffe3b3fe48.1490120798.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit makes sure the driver for the Armada 37xx pin controller is
enabled.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/Kconfig.platforms | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 129cc5ae4091..f2bb1691264f 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -105,6 +105,8 @@ config ARCH_MVEBU
 	select ARMADA_37XX_CLK
 	select MVEBU_ODMI
 	select MVEBU_PIC
+	select PINCTRL
+	select PINCTRL_ARMADA_37XX
 	help
 	  This enables support for Marvell EBU familly, including:
 	   - Armada 3700 SoC Family
-- 
git-series 0.9.1
