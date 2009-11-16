From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 16 Nov 2009 21:34:44 +0100
Subject: [PATCH 01/25] imx: reorder mx2x.h
In-Reply-To: <20091116203406.GA6546@pengutronix.de>
References: <20091116203406.GA6546@pengutronix.de>
Message-ID: <1258403708-10287-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mx2x.h |  138 ++++++++++++++++----------------
 1 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx2x.h b/arch/arm/plat-mxc/include/mach/mx2x.h
index db5d921..c0df87f 100644
--- a/arch/arm/plat-mxc/include/mach/mx2x.h
+++ b/arch/arm/plat-mxc/include/mach/mx2x.h
@@ -105,78 +105,78 @@
 	(((x) - X_MEMC_BASE_ADDR) + X_MEMC_BASE_ADDR_VIRT)
 
 /* fixed interrupt numbers */
-#define MXC_INT_LCDC		61
-#define MXC_INT_SLCDC		60
-#define MXC_INT_EMMAPP		52
-#define MXC_INT_EMMAPRP		51
-#define MXC_INT_DMACH15		47
-#define MXC_INT_DMACH14		46
-#define MXC_INT_DMACH13		45
-#define MXC_INT_DMACH12		44
-#define MXC_INT_DMACH11		43
-#define MXC_INT_DMACH10		42
-#define MXC_INT_DMACH9		41
-#define MXC_INT_DMACH8		40
-#define MXC_INT_DMACH7		39
-#define MXC_INT_DMACH6		38
-#define MXC_INT_DMACH5		37
-#define MXC_INT_DMACH4		36
-#define MXC_INT_DMACH3		35
-#define MXC_INT_DMACH2		34
-#define MXC_INT_DMACH1		33
-#define MXC_INT_DMACH0		32
-#define MXC_INT_CSI		31
-#define MXC_INT_NANDFC		29
-#define MXC_INT_PCMCIA		28
-#define MXC_INT_WDOG		27
-#define MXC_INT_GPT1		26
-#define MXC_INT_GPT2		25
-#define MXC_INT_GPT3		24
-#define MXC_INT_GPT		INT_GPT1
-#define MXC_INT_PWM		23
-#define MXC_INT_RTC		22
-#define MXC_INT_KPP		21
-#define MXC_INT_UART1		20
-#define MXC_INT_UART2		19
-#define MXC_INT_UART3		18
-#define MXC_INT_UART4		17
-#define MXC_INT_CSPI1		16
-#define MXC_INT_CSPI2		15
-#define MXC_INT_SSI1		14
-#define MXC_INT_SSI2		13
-#define MXC_INT_I2C		12
-#define MXC_INT_SDHC1		11
-#define MXC_INT_SDHC2		10
-#define MXC_INT_GPIO		8
 #define MXC_INT_CSPI3		6
+#define MXC_INT_GPIO		8
+#define MXC_INT_SDHC2		10
+#define MXC_INT_SDHC1		11
+#define MXC_INT_I2C		12
+#define MXC_INT_SSI2		13
+#define MXC_INT_SSI1		14
+#define MXC_INT_CSPI2		15
+#define MXC_INT_CSPI1		16
+#define MXC_INT_UART4		17
+#define MXC_INT_UART3		18
+#define MXC_INT_UART2		19
+#define MXC_INT_UART1		20
+#define MXC_INT_KPP		21
+#define MXC_INT_RTC		22
+#define MXC_INT_PWM		23
+#define MXC_INT_GPT		INT_GPT1
+#define MXC_INT_GPT3		24
+#define MXC_INT_GPT2		25
+#define MXC_INT_GPT1		26
+#define MXC_INT_WDOG		27
+#define MXC_INT_PCMCIA		28
+#define MXC_INT_NANDFC		29
+#define MXC_INT_CSI		31
+#define MXC_INT_DMACH0		32
+#define MXC_INT_DMACH1		33
+#define MXC_INT_DMACH2		34
+#define MXC_INT_DMACH3		35
+#define MXC_INT_DMACH4		36
+#define MXC_INT_DMACH5		37
+#define MXC_INT_DMACH6		38
+#define MXC_INT_DMACH7		39
+#define MXC_INT_DMACH8		40
+#define MXC_INT_DMACH9		41
+#define MXC_INT_DMACH10		42
+#define MXC_INT_DMACH11		43
+#define MXC_INT_DMACH12		44
+#define MXC_INT_DMACH13		45
+#define MXC_INT_DMACH14		46
+#define MXC_INT_DMACH15		47
+#define MXC_INT_EMMAPRP		51
+#define MXC_INT_EMMAPP		52
+#define MXC_INT_SLCDC		60
+#define MXC_INT_LCDC		61
 
 /* fixed DMA request numbers */
-#define DMA_REQ_CSI_RX          31
-#define DMA_REQ_CSI_STAT        30
-#define DMA_REQ_UART1_TX        27
-#define DMA_REQ_UART1_RX        26
-#define DMA_REQ_UART2_TX        25
-#define DMA_REQ_UART2_RX        24
-#define DMA_REQ_UART3_TX        23
-#define DMA_REQ_UART3_RX        22
-#define DMA_REQ_UART4_TX        21
-#define DMA_REQ_UART4_RX        20
-#define DMA_REQ_CSPI1_TX        19
-#define DMA_REQ_CSPI1_RX        18
-#define DMA_REQ_CSPI2_TX        17
-#define DMA_REQ_CSPI2_RX        16
-#define DMA_REQ_SSI1_TX1        15
-#define DMA_REQ_SSI1_RX1        14
-#define DMA_REQ_SSI1_TX0        13
-#define DMA_REQ_SSI1_RX0        12
-#define DMA_REQ_SSI2_TX1        11
-#define DMA_REQ_SSI2_RX1        10
-#define DMA_REQ_SSI2_TX0        9
-#define DMA_REQ_SSI2_RX0        8
-#define DMA_REQ_SDHC1           7
-#define DMA_REQ_SDHC2           6
-#define DMA_REQ_EXT             3
-#define DMA_REQ_CSPI3_TX        2
 #define DMA_REQ_CSPI3_RX        1
+#define DMA_REQ_CSPI3_TX        2
+#define DMA_REQ_EXT             3
+#define DMA_REQ_SDHC2           6
+#define DMA_REQ_SDHC1           7
+#define DMA_REQ_SSI2_RX0        8
+#define DMA_REQ_SSI2_TX0        9
+#define DMA_REQ_SSI2_RX1        10
+#define DMA_REQ_SSI2_TX1        11
+#define DMA_REQ_SSI1_RX0        12
+#define DMA_REQ_SSI1_TX0        13
+#define DMA_REQ_SSI1_RX1        14
+#define DMA_REQ_SSI1_TX1        15
+#define DMA_REQ_CSPI2_RX        16
+#define DMA_REQ_CSPI2_TX        17
+#define DMA_REQ_CSPI1_RX        18
+#define DMA_REQ_CSPI1_TX        19
+#define DMA_REQ_UART4_RX        20
+#define DMA_REQ_UART4_TX        21
+#define DMA_REQ_UART3_RX        22
+#define DMA_REQ_UART3_TX        23
+#define DMA_REQ_UART2_RX        24
+#define DMA_REQ_UART2_TX        25
+#define DMA_REQ_UART1_RX        26
+#define DMA_REQ_UART1_TX        27
+#define DMA_REQ_CSI_STAT        30
+#define DMA_REQ_CSI_RX          31
 
 #endif /* __ASM_ARCH_MXC_MX2x_H__ */
-- 
1.6.5.2
