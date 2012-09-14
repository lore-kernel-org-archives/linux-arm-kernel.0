From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 14 Sep 2012 12:35:18 -0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable CONFIG_GPIO_MC9S08DZ60
Message-ID: <1347636918-22724-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On mx35pdk board there is an 8-bit microcontroller that controls several IOs, such
as backlight enable pin, USB host VBUS, etc.

Let it build it by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 565132d..30d8fd2 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -140,6 +140,7 @@ CONFIG_I2C_IMX=y
 CONFIG_SPI=y
 CONFIG_SPI_IMX=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_MC9S08DZ60=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_IMX2_WDT=y
-- 
1.7.9.5
