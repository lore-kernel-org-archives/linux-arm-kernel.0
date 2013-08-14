From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 14 Aug 2013 10:17:47 -0300
Subject: [PATCH v2 1/2] ARM: imx_v6_v7_defconfig: Remove CONFIG_USB_PHY
 selection
Message-ID: <1376486268-31599-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit 052a11d1 (usb: phy: make PHY driver selection possible by
controller drivers), CONFIG_USB_PHY is selected via drivers/usb/phy/Kconfig, so
there is no need to select it via defconfig anymore.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Split it in two patches

 arch/arm/configs/imx_v6_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 5d488c2..402f282 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -195,7 +195,6 @@ CONFIG_USB_EHCI_MXC=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_HOST=y
-CONFIG_USB_PHY=y
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_MXS_PHY=y
 CONFIG_MMC=y
-- 
1.8.1.2
