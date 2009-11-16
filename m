From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 16 Nov 2009 21:34:46 +0100
Subject: [PATCH 03/25] imx: reorder mx27.h
In-Reply-To: <1258403708-10287-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091116203406.GA6546@pengutronix.de>
	<1258403708-10287-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1258403708-10287-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mx27.h |   63 +++++++++++++++++----------------
 1 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx27.h b/arch/arm/plat-mxc/include/mach/mx27.h
index dc3ad9a..0104c20 100644
--- a/arch/arm/plat-mxc/include/mach/mx27.h
+++ b/arch/arm/plat-mxc/include/mach/mx27.h
@@ -24,9 +24,6 @@
 #ifndef __ASM_ARCH_MXC_MX27_H__
 #define __ASM_ARCH_MXC_MX27_H__
 
-/* IRAM */
-#define IRAM_BASE_ADDR          0xFFFF4C00	/* internal ram */
-
 #define MSHC_BASE_ADDR          (AIPI_BASE_ADDR + 0x18000)
 #define GPT5_BASE_ADDR          (AIPI_BASE_ADDR + 0x19000)
 #define GPT4_BASE_ADDR          (AIPI_BASE_ADDR + 0x1A000)
@@ -60,7 +57,6 @@
 #define CS3_BASE_ADDR           0xD2000000
 #define CS4_BASE_ADDR           0xD4000000
 #define CS5_BASE_ADDR           0xD6000000
-#define PCMCIA_MEM_BASE_ADDR    0xDC000000
 
 /* NAND, SDRAM, WEIM, M3IF, EMI controllers */
 #define X_MEMC_BASE_ADDR        0xD8000000
@@ -73,38 +69,43 @@
 #define M3IF_BASE_ADDR          (X_MEMC_BASE_ADDR + 0x3000)
 #define PCMCIA_CTL_BASE_ADDR    (X_MEMC_BASE_ADDR + 0x4000)
 
+#define PCMCIA_MEM_BASE_ADDR    0xDC000000
+
+/* IRAM */
+#define IRAM_BASE_ADDR          0xFFFF4C00	/* internal ram */
+
 /* fixed interrupt numbers */
-#define MXC_INT_CCM		63
-#define MXC_INT_IIM		62
-#define MXC_INT_SAHARA		59
-#define MXC_INT_SCC_SCM		58
-#define MXC_INT_SCC_SMN		57
-#define MXC_INT_USB3		56
-#define MXC_INT_USB2		55
-#define MXC_INT_USB1		54
-#define MXC_INT_VPU		53
-#define MXC_INT_FEC		50
-#define MXC_INT_UART5		49
-#define MXC_INT_UART6		48
-#define MXC_INT_ATA		30
-#define MXC_INT_SDHC3		9
-#define MXC_INT_SDHC		7
-#define MXC_INT_RTIC		5
-#define MXC_INT_GPT4		4
-#define MXC_INT_GPT5		3
-#define MXC_INT_GPT6		2
 #define MXC_INT_I2C2		1
+#define MXC_INT_GPT6		2
+#define MXC_INT_GPT5		3
+#define MXC_INT_GPT4		4
+#define MXC_INT_RTIC		5
+#define MXC_INT_SDHC		7
+#define MXC_INT_SDHC3		9
+#define MXC_INT_ATA		30
+#define MXC_INT_UART6		48
+#define MXC_INT_UART5		49
+#define MXC_INT_FEC		50
+#define MXC_INT_VPU		53
+#define MXC_INT_USB1		54
+#define MXC_INT_USB2		55
+#define MXC_INT_USB3		56
+#define MXC_INT_SCC_SMN		57
+#define MXC_INT_SCC_SCM		58
+#define MXC_INT_SAHARA		59
+#define MXC_INT_IIM		62
+#define MXC_INT_CCM		63
 
 /* fixed DMA request numbers */
-#define DMA_REQ_NFC             37
-#define DMA_REQ_SDHC3           36
-#define DMA_REQ_UART6_RX        35
-#define DMA_REQ_UART6_TX        34
-#define DMA_REQ_UART5_RX        33
-#define DMA_REQ_UART5_TX        32
-#define DMA_REQ_ATA_RCV         29
-#define DMA_REQ_ATA_TX          28
 #define DMA_REQ_MSHC            4
+#define DMA_REQ_ATA_TX          28
+#define DMA_REQ_ATA_RCV         29
+#define DMA_REQ_UART5_TX        32
+#define DMA_REQ_UART5_RX        33
+#define DMA_REQ_UART6_TX        34
+#define DMA_REQ_UART6_RX        35
+#define DMA_REQ_SDHC3           36
+#define DMA_REQ_NFC             37
 
 /* silicon revisions specific to i.MX27 */
 #define CHIP_REV_1_0		0x00
-- 
1.6.5.2
