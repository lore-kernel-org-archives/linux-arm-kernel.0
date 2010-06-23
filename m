From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 23 Jun 2010 13:31:26 +0300
Subject: [PATCH 1/2] mx25: add iomux defines for UART4 on KPP pins
In-Reply-To: <cover.1277288487.git.baruch@tkos.co.il>
References: <cover.1277288487.git.baruch@tkos.co.il>
Message-ID: <c50a5b2770e542b5c55613d54fa5a46a0ac80a48.1277288487.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/plat-mxc/include/mach/iomux-mx25.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx25.h b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
index e88d01a..a2c2657 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx25.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx25.h
@@ -389,15 +389,19 @@
 #define MX25_PAD_KPP_ROW3__GPIO_3_0	IOMUX_PAD(0x3ac, 0x1b4, 0x15, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_KPP_COL0__KPP_COL0	IOMUX_PAD(0x3b0, 0x1b8, 0x10, 0, 0, KPP_CTL_COL)
+#define MX25_PAD_KPP_COL0__UART4_RXD_MUX IOMUX_PAD(0x3b0, 0x1b8, 0x11, 0x570, 1, NO_PAD_CTRL)
 #define MX25_PAD_KPP_COL0__GPIO_3_1	IOMUX_PAD(0x3b0, 0x1b8, 0x15, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_KPP_COL1__KPP_COL1	IOMUX_PAD(0x3b4, 0x1bc, 0x10, 0, 0, KPP_CTL_COL)
+#define MX25_PAD_KPP_COL1__UART4_TXD_MUX IOMUX_PAD(0x3b4, 0x1bc, 0x11, 0, 0, NO_PAD_CTRL)
 #define MX25_PAD_KPP_COL1__GPIO_3_2	IOMUX_PAD(0x3b4, 0x1bc, 0x15, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_KPP_COL2__KPP_COL2	IOMUX_PAD(0x3b8, 0x1c0, 0x10, 0, 0, KPP_CTL_COL)
+#define MX25_PAD_KPP_COL2__UART4_RTS	IOMUX_PAD(0x3b8, 0x1c0, 0x11, 0, 0, NO_PAD_CTRL)
 #define MX25_PAD_KPP_COL2__GPIO_3_3	IOMUX_PAD(0x3b8, 0x1c0, 0x15, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_KPP_COL3__KPP_COL3	IOMUX_PAD(0x3bc, 0x1c4, 0x10, 0, 0, KPP_CTL_COL)
+#define MX25_PAD_KPP_COL3__UART4_CTS	IOMUX_PAD(0x3bc, 0x1c4, 0x11, 0, 0, NO_PAD_CTRL)
 #define MX25_PAD_KPP_COL3__GPIO_3_4	IOMUX_PAD(0x3bc, 0x1c4, 0x15, 0, 0, NO_PAD_CTRL)
 
 #define MX25_PAD_FEC_MDC__FEC_MDC	IOMUX_PAD(0x3c0, 0x1c8, 0x10, 0, 0, NO_PAD_CTRL)
-- 
1.7.1
