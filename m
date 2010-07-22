From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 22 Jul 2010 18:29:21 +0200
Subject: [PATCH V2 2/6] mx25: add flexcan address and interrupt definition
In-Reply-To: <1279816165-6542-1-git-send-email-mkl@pengutronix.de>
References: <1279816165-6542-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1279816165-6542-3-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mx25.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx25.h b/arch/arm/plat-mxc/include/mach/mx25.h
index 11b044f..4a6f800 100644
--- a/arch/arm/plat-mxc/include/mach/mx25.h
+++ b/arch/arm/plat-mxc/include/mach/mx25.h
@@ -13,6 +13,8 @@
 
 #define MX25_I2C1_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0x80000)
 #define MX25_I2C3_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0x84000)
+#define MX25_CAN1_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0x88000)
+#define MX25_CAN2_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0x8c000)
 #define MX25_I2C2_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0x98000)
 #define MX25_CSPI1_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0xa4000)
 #define MX25_IOMUXC_BASE_ADDR		(MX25_AIPS1_BASE_ADDR + 0xac000)
@@ -70,6 +72,8 @@
 #define MX25_INT_NANDFC		33
 #define MX25_INT_LCDC		39
 #define MX25_INT_UART5		40
+#define MX25_INT_CAN1		43
+#define MX25_INT_CAN2		44
 #define MX25_INT_UART1		45
 #define MX25_INT_FEC		57
 
-- 
1.7.1
