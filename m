From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 14 Feb 2011 10:23:47 +0800
Subject: [PATCH v2 2/3] ARM: mxs: add dma channel definitions
In-Reply-To: <1297650228-12762-1-git-send-email-shawn.guo@freescale.com>
References: <1297650228-12762-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1297650228-12762-3-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/include/mach/mx23.h |   24 +++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/mx28.h |   37 +++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/mx23.h b/arch/arm/mach-mxs/include/mach/mx23.h
index 9edd02e..1730c9c 100644
--- a/arch/arm/mach-mxs/include/mach/mx23.h
+++ b/arch/arm/mach-mxs/include/mach/mx23.h
@@ -142,4 +142,28 @@
 #define MX23_INT_VDD5V_DROOP		64
 #define MX23_INT_DCDC4P2_BO		65
 
+/*
+ * APBH DMA
+ */
+#define MX23_DMA_SSP1			1
+#define MX23_DMA_SSP2			2
+#define MX23_DMA_GPMI0			4
+#define MX23_DMA_GPMI1			5
+#define MX23_DMA_GPMI2			6
+#define MX23_DMA_GPMI3			7
+
+/*
+ * APBX DMA
+ */
+#define MX23_DMA_ADC			0
+#define MX23_DMA_DAC			1
+#define MX23_DMA_SPDIF			2
+#define MX23_DMA_I2C			3
+#define MX23_DMA_SAIF0			4
+#define MX23_DMA_UART0_RX		6
+#define MX23_DMA_UART0_TX		7
+#define MX23_DMA_UART1_RX		8
+#define MX23_DMA_UART1_TX		9
+#define MX23_DMA_SAIF1			10
+
 #endif /* __MACH_MX23_H__ */
diff --git a/arch/arm/mach-mxs/include/mach/mx28.h b/arch/arm/mach-mxs/include/mach/mx28.h
index 0716745..3f3485a 100644
--- a/arch/arm/mach-mxs/include/mach/mx28.h
+++ b/arch/arm/mach-mxs/include/mach/mx28.h
@@ -185,4 +185,41 @@
 #define MX28_INT_GPIO1			126
 #define MX28_INT_GPIO0			127
 
+/*
+ * APBH DMA
+ */
+#define MX28_DMA_SSP0			0
+#define MX28_DMA_SSP1			1
+#define MX28_DMA_SSP2			2
+#define MX28_DMA_SSP3			3
+#define MX28_DMA_GPMI0			4
+#define MX28_DMA_GPMI1			5
+#define MX28_DMA_GPMI2			6
+#define MX28_DMA_GPMI3			7
+#define MX28_DMA_GPMI4			8
+#define MX28_DMA_GPMI5			9
+#define MX28_DMA_GPMI6			10
+#define MX28_DMA_GPMI7			11
+#define MX28_DMA_HSADC			12
+#define MX28_DMA_LCDIF			13
+
+/*
+ * APBX DMA
+ */
+#define MX28_DMA_AUART4_RX		0
+#define MX28_DMA_AUART4_TX		1
+#define MX28_DMA_SPDIF_TX		2
+#define MX28_DMA_SAIF0			4
+#define MX28_DMA_SAIF1			5
+#define MX28_DMA_I2C0			6
+#define MX28_DMA_I2C1			7
+#define MX28_DMA_AUART0_RX		8
+#define MX28_DMA_AUART0_TX		9
+#define MX28_DMA_AUART1_RX		10
+#define MX28_DMA_AUART1_TX		11
+#define MX28_DMA_AUART2_RX		12
+#define MX28_DMA_AUART2_TX		13
+#define MX28_DMA_AUART3_RX		14
+#define MX28_DMA_AUART3_TX		15
+
 #endif /* __MACH_MX28_H__ */
-- 
1.7.1
