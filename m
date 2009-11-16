From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 16 Nov 2009 21:34:53 +0100
Subject: [PATCH 10/25] imx: add namespace prefixes for symbols in mx35.h
In-Reply-To: <1258403708-10287-9-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091116203406.GA6546@pengutronix.de>
	<1258403708-10287-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-3-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-4-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-5-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-6-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-7-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-9-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1258403708-10287-10-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The old names are still defined using the new names.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mx35.h |   49 +++++++++++++++++++++-----------
 1 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
index ab4cfec..42b2a99 100644
--- a/arch/arm/plat-mxc/include/mach/mx35.h
+++ b/arch/arm/plat-mxc/include/mach/mx35.h
@@ -2,29 +2,44 @@
  * IRAM
  */
 #define MX35_IRAM_BASE_ADDR		0x10000000	/* internal ram */
-#define MX35_IRAM_SIZE		SZ_128K
+#define MX35_IRAM_SIZE			SZ_128K
 
-#define MXC_FEC_BASE_ADDR	0x50038000
-#define MX35_OTG_BASE_ADDR	0x53ff4000
-#define MX35_NFC_BASE_ADDR	0xBB000000
+#define MX35_FEC_BASE_ADDR		0x50038000
+#define MX35_OTG_BASE_ADDR		0x53ff4000
+#define MX35_NFC_BASE_ADDR		0xbb000000
 
 /*
  * Interrupt numbers
  */
-#define MXC_INT_OWIRE		2
+#define MX35_INT_OWIRE		2
 #define MX35_INT_MMC_SDHC1	7
-#define MXC_INT_MMC_SDHC2	8
-#define MXC_INT_MMC_SDHC3	9
+#define MX35_INT_MMC_SDHC2	8
+#define MX35_INT_MMC_SDHC3	9
 #define MX35_INT_SSI1		11
 #define MX35_INT_SSI2		12
-#define MXC_INT_GPU2D		16
-#define MXC_INT_ASRC		17
-#define MXC_INT_USBHS		35
-#define MXC_INT_USBOTG		37
-#define MXC_INT_ESAI		40
-#define MXC_INT_CAN1		43
-#define MXC_INT_CAN2		44
-#define MXC_INT_MLB		46
-#define MXC_INT_SPDIF		47
-#define MXC_INT_FEC		57
+#define MX35_INT_GPU2D		16
+#define MX35_INT_ASRC		17
+#define MX35_INT_USBHS		35
+#define MX35_INT_USBOTG		37
+#define MX35_INT_ESAI		40
+#define MX35_INT_CAN1		43
+#define MX35_INT_CAN2		44
+#define MX35_INT_MLB		46
+#define MX35_INT_SPDIF		47
+#define MX35_INT_FEC		57
 
+/* these should go away */
+#define MXC_FEC_BASE_ADDR MX35_FEC_BASE_ADDR
+#define MXC_INT_OWIRE MX35_INT_OWIRE
+#define MXC_INT_MMC_SDHC2 MX35_INT_MMC_SDHC2
+#define MXC_INT_MMC_SDHC3 MX35_INT_MMC_SDHC3
+#define MXC_INT_GPU2D MX35_INT_GPU2D
+#define MXC_INT_ASRC MX35_INT_ASRC
+#define MXC_INT_USBHS MX35_INT_USBHS
+#define MXC_INT_USBOTG MX35_INT_USBOTG
+#define MXC_INT_ESAI MX35_INT_ESAI
+#define MXC_INT_CAN1 MX35_INT_CAN1
+#define MXC_INT_CAN2 MX35_INT_CAN2
+#define MXC_INT_MLB MX35_INT_MLB
+#define MXC_INT_SPDIF MX35_INT_SPDIF
+#define MXC_INT_FEC MX35_INT_FEC
-- 
1.6.5.2
