From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Mon,  4 Jan 2016 11:17:46 +0800
Subject: [PATCH] ARM64: defconfig: remove CONFIG_MMC_DW_IDMAC
Message-ID: <1451877466-21557-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dw_mmc driver never use this macro, so we remove it from
arch/arm64/configs/defconfig

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index bdd7aa3..2c56551 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -157,7 +157,6 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SPI=y
 CONFIG_MMC_DW=y
-CONFIG_MMC_DW_IDMAC=y
 CONFIG_MMC_DW_PLTFM=y
 CONFIG_MMC_DW_EXYNOS=y
 CONFIG_NEW_LEDS=y
-- 
2.3.7
