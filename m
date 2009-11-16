From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 16 Nov 2009 21:34:47 +0100
Subject: [PATCH 04/25] imx: reorder mx3x.h
In-Reply-To: <1258403708-10287-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091116203406.GA6546@pengutronix.de>
	<1258403708-10287-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<1258403708-10287-3-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1258403708-10287-4-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-mxc/include/mach/mx3x.h |   45 +++++++++++++++++----------------
 1 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx3x.h b/arch/arm/plat-mxc/include/mach/mx3x.h
index 009f444..3e07d3d 100644
--- a/arch/arm/plat-mxc/include/mach/mx3x.h
+++ b/arch/arm/plat-mxc/include/mach/mx3x.h
@@ -34,21 +34,6 @@
  *         	C0000000	64M	PCMCIA/CF
  */
 
-#define CS0_BASE_ADDR		0xA0000000
-#define CS1_BASE_ADDR		0xA8000000
-#define CS2_BASE_ADDR		0xB0000000
-#define CS3_BASE_ADDR		0xB2000000
-
-#define CS4_BASE_ADDR		0xB4000000
-#define CS4_BASE_ADDR_VIRT	0xF4000000
-#define CS4_SIZE		SZ_32M
-
-#define CS5_BASE_ADDR		0xB6000000
-#define CS5_BASE_ADDR_VIRT	0xF6000000
-#define CS5_SIZE		SZ_32M
-
-#define PCMCIA_MEM_BASE_ADDR	0xBC000000
-
 /*
  * L2CC
  */
@@ -101,6 +86,7 @@
 #define AIPS2_BASE_ADDR		0x53F00000
 #define AIPS2_BASE_ADDR_VIRT	0xFC200000
 #define AIPS2_SIZE		SZ_1M
+
 #define CCM_BASE_ADDR		(AIPS2_BASE_ADDR + 0x00080000)
 #define GPT1_BASE_ADDR		(AIPS2_BASE_ADDR + 0x00090000)
 #define EPIT1_BASE_ADDR		(AIPS2_BASE_ADDR + 0x00094000)
@@ -130,6 +116,27 @@
 #define AVIC_SIZE		SZ_1M
 
 /*
+ * Memory regions and CS
+ */
+#define IPU_MEM_BASE_ADDR	0x70000000
+#define CSD0_BASE_ADDR		0x80000000
+#define CSD1_BASE_ADDR		0x90000000
+
+#define CS0_BASE_ADDR		0xA0000000
+#define CS1_BASE_ADDR		0xA8000000
+#define CS2_BASE_ADDR		0xB0000000
+#define CS3_BASE_ADDR		0xB2000000
+
+#define CS4_BASE_ADDR		0xB4000000
+#define CS4_BASE_ADDR_VIRT	0xF4000000
+#define CS4_SIZE		SZ_32M
+
+#define CS5_BASE_ADDR		0xB6000000
+#define CS5_BASE_ADDR_VIRT	0xF6000000
+#define CS5_SIZE		SZ_32M
+
+
+/*
  * NAND, SDRAM, WEIM, M3IF, EMI controllers
  */
 #define X_MEMC_BASE_ADDR	0xB8000000
@@ -142,12 +149,7 @@
 #define EMI_CTL_BASE_ADDR	(X_MEMC_BASE_ADDR + 0x4000)
 #define PCMCIA_CTL_BASE_ADDR	EMI_CTL_BASE_ADDR
 
-/*
- * Memory regions and CS
- */
-#define IPU_MEM_BASE_ADDR	0x70000000
-#define CSD0_BASE_ADDR		0x80000000
-#define CSD1_BASE_ADDR		0x90000000
+#define PCMCIA_MEM_BASE_ADDR	0xBC000000
 
 /*!
  * This macro defines the physical to virtual address mapping for all the
@@ -272,4 +274,3 @@ static inline int mx31_revision(void)
 #endif
 
 #endif /*  __ASM_ARCH_MXC_MX31_H__ */
-
-- 
1.6.5.2
