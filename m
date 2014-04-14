From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 14 Apr 2014 12:57:38 +0800
Subject: [PATCH] ARM: imx: drop CONFIG_MMC_UNSAFE_RESUME from defconfig
Message-ID: <1397451458-27296-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 2501c91 (mmc: core: Use MMC_UNSAFE_RESUME as default behavior),
CONFIG_MMC_UNSAFE_RESUME is not available anymore.  Drop it from imx
defconfig.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/configs/imx_v4_v5_defconfig | 1 -
 arch/arm/configs/imx_v6_v7_defconfig | 1 -
 arch/arm/configs/mxs_defconfig       | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index ec9b365..54bc649 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -160,7 +160,6 @@ CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_MMC=y
-CONFIG_MMC_UNSAFE_RESUME=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_ESDHC_IMX=y
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 0e00528..bf5ad0f 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -223,7 +223,6 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_ETH=m
 CONFIG_USB_MASS_STORAGE=m
 CONFIG_MMC=y
-CONFIG_MMC_UNSAFE_RESUME=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_ESDHC_IMX=y
diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 40e87c4..5170239 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -118,7 +118,6 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_ETH=m
 CONFIG_USB_MASS_STORAGE=m
 CONFIG_MMC=y
-CONFIG_MMC_UNSAFE_RESUME=y
 CONFIG_MMC_MXS=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
-- 
1.8.3.2
