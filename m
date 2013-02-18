From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 18 Feb 2013 12:45:20 -0300
Subject: [PATCH] ARM: imx_v4_v5_defconfig: Add CONFIG_GPIO_SYSFS
Message-ID: <1361202320-25917-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CONFIG_GPIO_SYSFS as it is helpful for accessing GPIO from userspace.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v4_v5_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 02c657a..f07a847 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -109,6 +109,7 @@ CONFIG_I2C_IMX=y
 CONFIG_SPI=y
 CONFIG_SPI_IMX=y
 CONFIG_SPI_SPIDEV=y
+CONFIG_GPIO_SYSFS=y
 CONFIG_W1=y
 CONFIG_W1_MASTER_MXC=y
 CONFIG_W1_SLAVE_THERM=y
-- 
1.7.9.5
