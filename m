From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Fri, 29 Apr 2016 22:40:18 +0200
Subject: [PATCH 1/2] ARM: imx_v6_v7_defconfig: add CONFIG_I2C_GPIO
Message-ID: <1461962419-4715-1-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPIO-based bitbanging I2C driver is required to make HDMI work on
the Apalis iMX6 module plugged into a Ixora carrier board featuring a
DDC channel to read a screen's EDID being hooked up to regular GPIOs.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index b255c7f..fb959f9 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -184,6 +184,7 @@ CONFIG_I2C_MUX_GPIO=y
 # CONFIG_I2C_HELPER_AUTO is not set
 CONFIG_I2C_ALGOPCF=m
 CONFIG_I2C_ALGOPCA=m
+CONFIG_I2C_GPIO=y
 CONFIG_I2C_IMX=y
 CONFIG_SPI=y
 CONFIG_SPI_IMX=y
-- 
2.5.5
