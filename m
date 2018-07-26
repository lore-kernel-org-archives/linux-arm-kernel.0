From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Thu, 26 Jul 2018 13:05:22 -0300
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: Select
 CONFIG_SENSORS_MC13783_ADC
In-Reply-To: <1532621122-22013-1-git-send-email-fabio.estevam@nxp.com>
References: <1532621122-22013-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <1532621122-22013-2-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select the MC13783/MC13892 ADC functionality by default.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e2c1276..dda3910 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -211,6 +211,7 @@ CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_SYSCON=y
 CONFIG_POWER_RESET_SYSCON_POWEROFF=y
 CONFIG_POWER_SUPPLY=y
+CONFIG_SENSORS_MC13783_ADC=y
 CONFIG_SENSORS_GPIO_FAN=y
 CONFIG_SENSORS_IIO_HWMON=y
 CONFIG_THERMAL_WRITABLE_TRIPS=y
-- 
2.7.4
