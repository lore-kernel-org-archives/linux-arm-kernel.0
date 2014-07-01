From: silvio.fricke@gmail.com (Silvio Fricke)
Date: Tue,  1 Jul 2014 13:08:58 +0200
Subject: [PATCH v2 1/5] ARM: imx_v6_v7_defconfig: Enable STMPE gpio support
In-Reply-To: <cover.1404212584.git.silvio.fricke@gmail.com>
References: <cover.1404212584.git.silvio.fricke@gmail.com>
Message-ID: <1aa8d2d0f7877dc582a32cf7dc5162d639172ed7.1404212584.git.silvio.fricke@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable STMPE gpio support as this is used on MX6 Data Modul edm-qmx6
board.

Signed-off-by: Silvio Fricke <silvio.fricke@gmail.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 96e8417..c331de8 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -162,6 +162,7 @@ CONFIG_SPI=y
 CONFIG_SPI_IMX=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_MC9S08DZ60=y
+CONFIG_GPIO_STMPE=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_IMX2_WDT=y
-- 
2.0.0
