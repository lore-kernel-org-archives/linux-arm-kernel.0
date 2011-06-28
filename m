From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 28 Jun 2011 12:58:36 -0300
Subject: [PATCH] ARM: mx53: Fix some interrupts marked as reserved.
Message-ID: <1309276716-12828-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark the actual interrupt source for some interrupts currently marked as reserved.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/plat-mxc/include/mach/mx53.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mx53.h b/arch/arm/plat-mxc/include/mach/mx53.h
index 3128af7..5e3c323 100644
--- a/arch/arm/plat-mxc/include/mach/mx53.h
+++ b/arch/arm/plat-mxc/include/mach/mx53.h
@@ -233,7 +233,7 @@
 #define MX53_INT_ESDHC2	2
 #define MX53_INT_ESDHC3	3
 #define MX53_INT_ESDHC4	4
-#define MX53_INT_RESV5	5
+#define MX53_INT_DAP	5
 #define MX53_INT_SDMA	6
 #define MX53_INT_IOMUX	7
 #define MX53_INT_NFC	8
@@ -262,8 +262,8 @@
 #define MX53_INT_UART1	31
 #define MX53_INT_UART2	32
 #define MX53_INT_UART3	33
-#define MX53_INT_RESV34	34
-#define MX53_INT_RESV35	35
+#define MX53_INT_RTC	34
+#define MX53_INT_PTP	35
 #define MX53_INT_ECSPI1	36
 #define MX53_INT_ECSPI2	37
 #define MX53_INT_CSPI	38
@@ -293,8 +293,8 @@
 #define MX53_INT_I2C1	62
 #define MX53_INT_I2C2	63
 #define MX53_INT_I2C3	64
-#define MX53_INT_RESV65	65
-#define MX53_INT_RESV66	66
+#define MX53_INT_MLB	65
+#define MX53_INT_ASRC	66
 #define MX53_INT_SPDIF	67
 #define MX53_INT_SIM_DAT	68
 #define MX53_INT_IIM	69
-- 
1.6.0.4
