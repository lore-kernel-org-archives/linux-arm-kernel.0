From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 11 Mar 2013 20:18:16 -0300
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: Select CONFIG_W1_MASTER_MXC
In-Reply-To: <1363043896-16140-1-git-send-email-festevam@gmail.com>
References: <1363043896-16140-1-git-send-email-festevam@gmail.com>
Message-ID: <1363043896-16140-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Select CONFIG_W1_MASTER_MXC.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e36b010..50f9a7f 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -143,6 +143,8 @@ CONFIG_SPI=y
 CONFIG_SPI_IMX=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_MC9S08DZ60=y
+CONFIG_W1=y
+CONFIG_W1_MASTER_MXC=y
 # CONFIG_HWMON is not set
 CONFIG_WATCHDOG=y
 CONFIG_IMX2_WDT=y
-- 
1.7.9.5
