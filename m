From: marex@denx.de (Marek Vasut)
Date: Mon, 17 Oct 2016 18:34:33 +0200
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select the es8328 codec driver
Message-ID: <20161017163433.11938-1-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select CONFIG_SND_SOC_ES8328 so that we can have audio functional
by default on Kosagi Novena boards.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 8e66e22..cbe7faf 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -257,6 +257,7 @@ CONFIG_SND_IMX_SOC=y
 CONFIG_SND_SOC_PHYCORE_AC97=y
 CONFIG_SND_SOC_EUKREA_TLV320=y
 CONFIG_SND_SOC_IMX_WM8962=y
+CONFIG_SND_SOC_IMX_ES8328=y
 CONFIG_SND_SOC_IMX_SGTL5000=y
 CONFIG_SND_SOC_IMX_SPDIF=y
 CONFIG_SND_SOC_IMX_MC13783=y
-- 
2.9.3
