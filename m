From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Thu, 25 Feb 2016 12:46:31 +0200
Subject: [PATCH v3 1/2] arm64: defconfig: Add Qualcomm sdhci and restart
 functionality
Message-ID: <1456397192-2407-1-git-send-email-georgi.djakov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable sdhci and restart functionality for devices based on msm8916 platform.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
Changes since v2:
 * Move the MMC_BLOCK_MINORS change into a separate patch.

Changes since v1:
 * Rebased onto arm-soc/next/arm64

 arch/arm64/configs/defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 774e51fda7fa..47b5dac96bfc 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -153,6 +153,7 @@ CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
 CONFIG_GPIO_PL061=y
 CONFIG_GPIO_RCAR=y
 CONFIG_GPIO_XGENE=y
+CONFIG_POWER_RESET_MSM=y
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
 # CONFIG_HWMON is not set
@@ -195,6 +196,7 @@ CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_TEGRA=y
+CONFIG_MMC_SDHCI_MSM=y
 CONFIG_MMC_SPI=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_EXYNOS=y
