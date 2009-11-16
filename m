From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 16 Nov 2009 21:34:45 +0100
Subject: [PATCH 02/25] imx: reorder mx21.h
In-Reply-To: <1258403708-10287-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091116203406.GA6546@pengutronix.de>
	<1258403708-10287-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1258403708-10287-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mx21.h |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx21.h b/arch/arm/plat-mxc/include/mach/mx21.h
index 21112c6..2b1fccb 100644
--- a/arch/arm/plat-mxc/include/mach/mx21.h
+++ b/arch/arm/plat-mxc/include/mach/mx21.h
@@ -34,8 +34,8 @@
 #define CS2_BASE_ADDR           0xD0000000
 #define CS3_BASE_ADDR           0xD1000000
 #define CS4_BASE_ADDR           0xD2000000
-#define CS5_BASE_ADDR           0xDD000000
 #define PCMCIA_MEM_BASE_ADDR    0xD4000000
+#define CS5_BASE_ADDR           0xDD000000
 
 /* NAND, SDRAM, WEIM etc controllers */
 #define X_MEMC_BASE_ADDR        0xDF000000
@@ -50,21 +50,21 @@
 #define IRAM_BASE_ADDR          0xFFFFE800	/* internal ram */
 
 /* fixed interrupt numbers */
+#define MXC_INT_FIRI            9
+#define MXC_INT_BMI             30
+#define MXC_INT_EMMAENC         49
+#define MXC_INT_EMMADEC         50
+#define MXC_INT_USBWKUP         53
+#define MXC_INT_USBDMA          54
+#define MXC_INT_USBHOST         55
+#define MXC_INT_USBFUNC         56
+#define MXC_INT_USBMNP          57
 #define MXC_INT_USBCTRL         58
 #define MXC_INT_USBCTRL         58
-#define MXC_INT_USBMNP          57
-#define MXC_INT_USBFUNC         56
-#define MXC_INT_USBHOST         55
-#define MXC_INT_USBDMA          54
-#define MXC_INT_USBWKUP         53
-#define MXC_INT_EMMADEC         50
-#define MXC_INT_EMMAENC         49
-#define MXC_INT_BMI             30
-#define MXC_INT_FIRI            9
 
 /* fixed DMA request numbers */
-#define DMA_REQ_BMI_RX          29
-#define DMA_REQ_BMI_TX          28
 #define DMA_REQ_FIRI_RX         4
+#define DMA_REQ_BMI_TX          28
+#define DMA_REQ_BMI_RX          29
 
 #endif /* __ASM_ARCH_MXC_MX21_H__ */
-- 
1.6.5.2
