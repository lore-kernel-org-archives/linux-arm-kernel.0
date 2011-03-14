From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 14 Mar 2011 11:40:21 +0200
Subject: [PATCH] ARM: imx/mx25: add NAND chip select pins to iomux
Message-ID: <cae1d71db47204ee2654eca7391cb656ed53566b.1300095569.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/plat-mxc/include/mach/iomux-mx25.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx25.h b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
index d7f52c9..2e5244d 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx25.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
@@ -89,13 +89,16 @@
 #define MX25_PAD_CS0__GPIO_4_2		IOMUX_PAD(0x000, 0x04c, 0x05, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_CS1__CS1		IOMUX_PAD(0x000, 0x050, 0x00, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_CS1__NF_CE3		IOMUX_PAD(0x000, 0x050, 0x01, 0, 0, NO_PAD_CTRL)
 #define MX25_PAD_CS1__GPIO_4_3		IOMUX_PAD(0x000, 0x050, 0x05, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_CS4__CS4		IOMUX_PAD(0x264, 0x054, 0x10, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_CS4__NF_CE1		IOMUX_PAD(0x264, 0x054, 0x01, 0, 0, NO_PAD_CTRL)
 #define MX25_PAD_CS4__UART5_CTS		IOMUX_PAD(0x264, 0x054, 0x13, 0, 0, NO_PAD_CTRL)
 #define MX25_PAD_CS4__GPIO_3_20		IOMUX_PAD(0x264, 0x054, 0x15, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_CS5__CS5		IOMUX_PAD(0x268, 0x058, 0x10, 0, 0, NO_PAD_CTRL)
+#define MX25_PAD_CS5__NF_CE2		IOMUX_PAD(0x268, 0x058, 0x01, 0, 0, NO_PAD_CTRL)
 #define MX25_PAD_CS5__UART5_RTS		IOMUX_PAD(0x268, 0x058, 0x13, 0x574, 0, NO_PAD_CTRL)
 #define MX25_PAD_CS5__GPIO_3_21		IOMUX_PAD(0x268, 0x058, 0x15, 0, 0, NO_PAD_CTRL)
 
-- 
1.7.2.3
