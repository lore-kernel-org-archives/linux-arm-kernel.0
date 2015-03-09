From: peter.chen@freescale.com (Peter Chen)
Date: Mon, 9 Mar 2015 17:28:08 +0800
Subject: [PATCH 3/3] ARM: imx_v6_v7_defconfig: Add CONFIG_GPIO_PCA953X
In-Reply-To: <1425893288-1517-1-git-send-email-peter.chen@freescale.com>
References: <1425893288-1517-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1425893288-1517-4-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is used for max7310 gpio expandor which is used at imx6qdl
sabreauto board.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index cf1e71e..75e7a95 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -168,6 +168,7 @@ CONFIG_SPI=y
 CONFIG_SPI_IMX=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_MC9S08DZ60=y
+CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_STMPE=y
 CONFIG_POWER_SUPPLY=y
 CONFIG_POWER_RESET=y
-- 
1.9.1
