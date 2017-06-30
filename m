From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 30 Jun 2017 17:43:04 -0300
Subject: [PATCH 3/4] ARM: imx_v6_v7_defconfig: Enable SPI_GPIO
In-Reply-To: <1498855385-9690-1-git-send-email-festevam@gmail.com>
References: <1498855385-9690-1-git-send-email-festevam@gmail.com>
Message-ID: <1498855385-9690-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Some boards like imx7d-sdb provide SPIO functionality via GPIOs,
so enable the CONFIG_SPI_GPIO option.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e74de69..b043caf 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -193,6 +193,7 @@ CONFIG_I2C_ALGOPCA=m
 CONFIG_I2C_GPIO=y
 CONFIG_I2C_IMX=y
 CONFIG_SPI=y
+CONFIG_SPI_GPIO=y
 CONFIG_SPI_IMX=y
 CONFIG_SPI_FSL_DSPI=y
 CONFIG_GPIO_SYSFS=y
-- 
2.7.4
