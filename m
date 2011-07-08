From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 8 Jul 2011 14:59:49 -0300
Subject: [PATCH 1/2] ARM: mx25: Fix typo on CAN1_RX pad setting
Message-ID: <1310147990-9198-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/plat-mxc/include/mach/iomux-mx25.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx25.h b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
index 2e5244d..bf64e1e 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx25.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
@@ -457,7 +457,7 @@
 #define MX25_PAD_GPIO_A__USBOTG_PWR	IOMUX_PAD(0x3f0, 0x1f4, 0x12, 0, 0, PAD_CTL_PKE)
 
 #define MX25_PAD_GPIO_B__GPIO_B		IOMUX_PAD(0x3f4, 0x1f8, 0x10, 0, 0, NO_PAD_CTRL)
-#define MX25_PAD_GPIO_B__CAN1_RX	IOMUX_PAD(0x3f4, 0x1f8, 0x16, 0x480, 1, PAD_CTL_PUS_22K)
+#define MX25_PAD_GPIO_B__CAN1_RX	IOMUX_PAD(0x3f4, 0x1f8, 0x16, 0x480, 1, PAD_CTL_PUS_22K_UP)
 #define MX25_PAD_GPIO_B__USBOTG_OC	IOMUX_PAD(0x3f4, 0x1f8, 0x12, 0x57c, 1, PAD_CTL_PUS_100K_UP)
 
 #define MX25_PAD_GPIO_C__GPIO_C		IOMUX_PAD(0x3f8, 0x1fc, 0x10, 0, 0, NO_PAD_CTRL)
-- 
1.6.0.4
