From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Mon, 24 Aug 2015 18:01:15 +0530
Subject: [PATCH] arm64: defconfig: Enable samsung serial and mmc
Message-ID: <1440419475-14411-1-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch update defconfig, adds samsung serial and
Synopsys Designware MMC configs related to exynos SoC

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm64/configs/defconfig |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 34d71dd..c8ccda1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -109,6 +109,10 @@ CONFIG_SERIAL_8250_DW=y
 CONFIG_SERIAL_8250_MT6577=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
+CONFIG_SERIAL_SAMSUNG=y
+CONFIG_SERIAL_SAMSUNG_UARTS_4=y
+CONFIG_SERIAL_SAMSUNG_UARTS=4
+CONFIG_SERIAL_SAMSUNG_CONSOLE=y
 CONFIG_SERIAL_MSM=y
 CONFIG_SERIAL_MSM_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
@@ -145,6 +149,10 @@ CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SPI=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_IDMAC=y
+CONFIG_MMC_DW_PLTFM=y
+CONFIG_MMC_DW_EXYNOS=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_SYSCON=y
-- 
1.7.10.4
