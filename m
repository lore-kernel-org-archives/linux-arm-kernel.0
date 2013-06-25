From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 24 Jun 2013 22:50:17 -0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select CONFIG_NOP_USB_XCEIV by
 default
Message-ID: <1372125017-16294-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

In order to get USB functionality on mx5 boards, we need to select
CONFIG_NOP_USB_XCEIV option, so let's enable it by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 06686e7..0837aae 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -195,6 +195,7 @@ CONFIG_USB_EHCI_MXC=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_USB_PHY=y
+CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_MXS_PHY=y
 CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
-- 
1.8.1.2
