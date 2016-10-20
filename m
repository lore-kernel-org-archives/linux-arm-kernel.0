From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 20 Oct 2016 13:49:54 +0200
Subject: [PATCH] ARM64: defconfig: Enable MMC related configs
Message-ID: <1476964194-2194-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable MMC related defaults configs for MMC, PWM and PWM clock.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index dab2cb0..920f1e8 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -341,6 +341,7 @@ CONFIG_USB_RENESAS_USBHS_UDC=m
 CONFIG_MMC=y
 CONFIG_MMC_BLOCK_MINORS=32
 CONFIG_MMC_ARMMMCI=y
+CONFIG_MMC_MESON_GX=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ACPI=y
 CONFIG_MMC_SDHCI_PLTFM=y
@@ -387,6 +388,7 @@ CONFIG_XEN_GRANT_DEV_ALLOC=y
 CONFIG_COMMON_CLK_SCPI=y
 CONFIG_COMMON_CLK_CS2000_CP=y
 CONFIG_COMMON_CLK_S2MPS11=y
+CONFIG_COMMON_CLK_PWM=y
 CONFIG_CLK_QORIQ=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_MSM_GCC_8916=y
@@ -404,6 +406,7 @@ CONFIG_ARCH_TEGRA_210_SOC=y
 CONFIG_EXTCON_USB_GPIO=y
 CONFIG_PWM=y
 CONFIG_PWM_TEGRA=m
+CONFIG_PWM_MESON=m
 CONFIG_COMMON_RESET_HI6220=y
 CONFIG_PHY_RCAR_GEN3_USB2=y
 CONFIG_PHY_HI6220_USB=y
-- 
1.9.1
