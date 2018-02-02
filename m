From: s.riedmueller@phytec.de (Stefan Riedmueller)
Date: Fri, 2 Feb 2018 10:34:04 +0100
Subject: [PATCH v6 6/6] ARM: imx_v6_v7_defconfig: Enable Dialog Semiconductor
 DA9062 driver
Message-ID: <1517564044-8706-1-git-send-email-s.riedmueller@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The phyCORE-i.MX 6 uses the DA9062/63 PMIC, RTC and Watchdog driver.

Enable these options by default.

Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes in v6:
 - Rebased against imx/defconfig
---
 arch/arm/configs/imx_v6_v7_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 98c0691..79d63b4 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -222,8 +222,10 @@ CONFIG_THERMAL_WRITABLE_TRIPS=y
 CONFIG_CPU_THERMAL=y
 CONFIG_IMX_THERMAL=y
 CONFIG_WATCHDOG=y
+CONFIG_DA9062_WATCHDOG=y
 CONFIG_IMX2_WDT=y
 CONFIG_MFD_DA9052_I2C=y
+CONFIG_MFD_DA9062=y
 CONFIG_MFD_MC13XXX_SPI=y
 CONFIG_MFD_MC13XXX_I2C=y
 CONFIG_MFD_STMPE=y
@@ -231,6 +233,7 @@ CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_ANATOP=y
 CONFIG_REGULATOR_DA9052=y
+CONFIG_REGULATOR_DA9062=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_REGULATOR_MC13783=y
 CONFIG_REGULATOR_MC13892=y
@@ -356,6 +359,7 @@ CONFIG_RTC_DRV_ISL1208=y
 CONFIG_RTC_DRV_PCF8523=y
 CONFIG_RTC_DRV_PCF8563=y
 CONFIG_RTC_DRV_M41T80=y
+CONFIG_RTC_DRV_DA9063=y
 CONFIG_RTC_DRV_MC13XXX=y
 CONFIG_RTC_DRV_MXC=y
 CONFIG_RTC_DRV_MXC_V2=y
-- 
2.7.4
