From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Thu, 8 Jun 2017 19:26:57 +0300
Subject: [PATCH 1/2] ARM: imx_v6_v7_defconfig: Set THERMAL_WRITABLE_TRIPS=y
 for testing
Message-ID: <7055ce6095c0b7f026ac6f0dc37e43fc5c0b1793.1496939031.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setting trip points is supported by the imx thermal driver and it is
useful to be able to test this without adjusting config.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index bb6fa56..f7984a6 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -204,6 +204,7 @@ CONFIG_POWER_SUPPLY=y
 CONFIG_SENSORS_GPIO_FAN=y
 CONFIG_SENSORS_IIO_HWMON=y
 CONFIG_THERMAL=y
+CONFIG_THERMAL_WRITABLE_TRIPS=y
 CONFIG_CPU_THERMAL=y
 CONFIG_IMX_THERMAL=y
 CONFIG_WATCHDOG=y
-- 
2.7.4
