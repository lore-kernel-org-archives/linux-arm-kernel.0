From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 17 Feb 2011 14:28:49 +0800
Subject: [PATCH 1/4] ARM: mx23: rename mx23 auart irq definition to align with
	mx28
In-Reply-To: <1297924132-17402-1-git-send-email-shawn.guo@freescale.com>
References: <1297924132-17402-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1297924132-17402-2-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX23 Reference Manual names auart irq differently from i.MX28.
This patch is to align the naming with mx28, so that some device
registration codes can be shared.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/include/mach/mx23.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/mx23.h b/arch/arm/mach-mxs/include/mach/mx23.h
index 9edd02e..4768402 100644
--- a/arch/arm/mach-mxs/include/mach/mx23.h
+++ b/arch/arm/mach-mxs/include/mach/mx23.h
@@ -101,9 +101,9 @@
 #define MX23_INT_SSP2_DMA		20
 #define MX23_INT_ECC8_IRQ		21
 #define MX23_INT_RTC_ALARM		22
-#define MX23_INT_UARTAPP_TX_DMA		23
-#define MX23_INT_UARTAPP_INTERNAL	24
-#define MX23_INT_UARTAPP_RX_DMA		25
+#define MX23_INT_AUART1_TX_DMA		23
+#define MX23_INT_AUART1			24
+#define MX23_INT_AUART1_RX_DMA		25
 #define MX23_INT_I2C_DMA		26
 #define MX23_INT_I2C_ERROR		27
 #define MX23_INT_TIMER0			28
@@ -135,9 +135,9 @@
 #define MX23_INT_DCP			54
 #define MX23_INT_BCH			56
 #define MX23_INT_PXP			57
-#define MX23_INT_UARTAPP2_TX_DMA	58
-#define MX23_INT_UARTAPP2_INTERNAL	59
-#define MX23_INT_UARTAPP2_RX_DMA	60
+#define MX23_INT_AUART2_TX_DMA		58
+#define MX23_INT_AUART2			59
+#define MX23_INT_AUART2_RX_DMA		60
 #define MX23_INT_VDAC_DETECT		61
 #define MX23_INT_VDD5V_DROOP		64
 #define MX23_INT_DCDC4P2_BO		65
-- 
1.7.1
