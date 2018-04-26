From: Anson.Huang@nxp.com (Anson Huang)
Date: Thu, 26 Apr 2018 14:58:18 +0800
Subject: [PATCH V5 6/6] ARM: imx_v6_v7_defconfig: Select CONFIG_GPIO_MAX732X
 by default
In-Reply-To: <1524725898-27974-1-git-send-email-Anson.Huang@nxp.com>
References: <1524725898-27974-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1524725898-27974-6-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable max7320 IO expander for i.MX platforms.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no changes since V4.
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 3a30843..8455d39 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -199,6 +199,7 @@ CONFIG_SPI_GPIO=y
 CONFIG_SPI_IMX=y
 CONFIG_SPI_FSL_DSPI=y
 CONFIG_GPIO_SYSFS=y
+CONFIG_GPIO_MAX732X=y
 CONFIG_GPIO_MC9S08DZ60=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_STMPE=y
-- 
2.7.4
