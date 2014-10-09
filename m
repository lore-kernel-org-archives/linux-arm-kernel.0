From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 09 Oct 2014 13:32:58 +0200
Subject: [PATCH 2/3] ARM: multi_v7_defconfig: Enable Maxim 77836 for Gear2
 board
In-Reply-To: <1412854379-18875-1-git-send-email-k.kozlowski@samsung.com>
References: <1412854379-18875-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1412854379-18875-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable all Maxim 14577 drivers and Maxim 17040 fuel gauge driver to
support the Maxim 77836 PMIC present on Samsung Rinato board (Gear 2).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/multi_v7_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 9702b140ae04..3d37e9d2914f 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -247,6 +247,8 @@ CONFIG_GPIO_PALMAS=y
 CONFIG_GPIO_TPS6586X=y
 CONFIG_GPIO_TPS65910=y
 CONFIG_BATTERY_SBS=y
+CONFIG_BATTERY_MAX17040=y
+CONFIG_CHARGER_MAX14577=y
 CONFIG_CHARGER_TPS65090=y
 CONFIG_POWER_RESET_AS3722=y
 CONFIG_POWER_RESET_GPIO=y
@@ -266,6 +268,7 @@ CONFIG_MFD_AS3722=y
 CONFIG_MFD_BCM590XX=y
 CONFIG_MFD_CROS_EC=y
 CONFIG_MFD_CROS_EC_SPI=y
+CONFIG_MFD_MAX14577=y
 CONFIG_MFD_MAX8907=y
 CONFIG_MFD_SEC_CORE=y
 CONFIG_MFD_STMPE=y
@@ -277,6 +280,7 @@ CONFIG_REGULATOR_AB8500=y
 CONFIG_REGULATOR_AS3722=y
 CONFIG_REGULATOR_BCM590XX=y
 CONFIG_REGULATOR_GPIO=y
+CONFIG_REGULATOR_MAX14577=y
 CONFIG_REGULATOR_MAX8907=y
 CONFIG_REGULATOR_PALMAS=y
 CONFIG_REGULATOR_S2MPS11=y
@@ -415,6 +419,8 @@ CONFIG_MSM_MMCC_8960=y
 CONFIG_MSM_MMCC_8974=y
 CONFIG_TEGRA_IOMMU_GART=y
 CONFIG_TEGRA_IOMMU_SMMU=y
+CONFIG_EXTCON=y
+CONFIG_EXTCON_MAX14577=y
 CONFIG_MEMORY=y
 CONFIG_IIO=y
 CONFIG_XILINX_XADC=y
-- 
1.9.1
