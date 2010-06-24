From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 24 Jun 2010 11:57:02 +0300
Subject: [PATCH -next 1/2] mx25: add iomux defines for UART4 on KPP pins
In-Reply-To: <cover.1277369614.git.baruch@tkos.co.il>
References: <cover.1277369614.git.baruch@tkos.co.il>
Message-ID: <4f6f7f79eec5d595c5fafd719ed3fab1b64e46f2.1277369614.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/plat-mxc/include/mach/iomux-mx25.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx25.h b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
index 5bea603..cbc67c7 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx25.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
@@ -386,18 +386,22 @@
 #define MX25_PAD_KPP_ROW3__GPIO_3_0	IOMUX_PAD(0x3ac, 0x1b4, 0x15, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_KPP_COL0__KPP_COL0	IOMUX_PAD(0x3b0, 0x1b8, 0x10, 0, 0, PAD_CTL_PKE | PAD_CTL_ODE)
+#define MX25_PAD_KPP_COL0__UART4_RXD_MUX IOMUX_PAD(0x3b0, 0x1b8, 0x11, 0x570, 1, NO_PAD_CTRL)
 #define MX25_PAD_KPP_COL0__AUD5_TXD	IOMUX_PAD(0x3b0, 0x1b8, 0x12, 0, 0, PAD_CTL_PKE | PAD_CTL_PUS_100K_UP)
 #define MX25_PAD_KPP_COL0__GPIO_3_1	IOMUX_PAD(0x3b0, 0x1b8, 0x15, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_KPP_COL1__KPP_COL1	IOMUX_PAD(0x3b4, 0x1bc, 0x10, 0, 0, PAD_CTL_PKE | PAD_CTL_ODE)
+#define MX25_PAD_KPP_COL1__UART4_TXD_MUX IOMUX_PAD(0x3b4, 0x1bc, 0x11, 0, 0, NO_PAD_CTRL)
 #define MX25_PAD_KPP_COL1__AUD5_RXD	IOMUX_PAD(0x3b4, 0x1bc, 0x12, 0, 0, PAD_CTL_PKE | PAD_CTL_PUS_100K_UP)
 #define MX25_PAD_KPP_COL1__GPIO_3_2	IOMUX_PAD(0x3b4, 0x1bc, 0x15, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_KPP_COL2__KPP_COL2	IOMUX_PAD(0x3b8, 0x1c0, 0x10, 0, 0, PAD_CTL_PKE | PAD_CTL_ODE)
+#define MX25_PAD_KPP_COL2__UART4_RTS	IOMUX_PAD(0x3b8, 0x1c0, 0x11, 0, 0, NO_PAD_CTRL)
 #define MX25_PAD_KPP_COL2__AUD5_TXC	IOMUX_PAD(0x3b8, 0x1c0, 0x12, 0, 0, PAD_CTL_PKE | PAD_CTL_PUS_100K_UP)
 #define MX25_PAD_KPP_COL2__GPIO_3_3	IOMUX_PAD(0x3b8, 0x1c0, 0x15, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_KPP_COL3__KPP_COL3	IOMUX_PAD(0x3bc, 0x1c4, 0x10, 0, 0, PAD_CTL_PKE | PAD_CTL_ODE)
+#define MX25_PAD_KPP_COL3__UART4_CTS	IOMUX_PAD(0x3bc, 0x1c4, 0x11, 0, 0, NO_PAD_CTRL)
 #define MX25_PAD_KPP_COL3__AUD5_TXFS	IOMUX_PAD(0x3bc, 0x1c4, 0x12, 0, 0, PAD_CTL_PKE | PAD_CTL_PUS_100K_UP)
 #define MX25_PAD_KPP_COL3__GPIO_3_4	IOMUX_PAD(0x3bc, 0x1c4, 0x15, 0, 0, NO_PAD_CTRL)
 
-- 
1.7.1
