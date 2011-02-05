From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 5 Feb 2011 10:18:43 +0800
Subject: [PATCH 3/7] ARM: mxs: make ssp error irq definition consistent
In-Reply-To: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
References: <1296872327-21166-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1296872327-21166-4-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/include/mach/mx23.h |    2 +-
 arch/arm/mach-mxs/include/mach/mx28.h |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/mx23.h b/arch/arm/mach-mxs/include/mach/mx23.h
index 1730c9c..e858692 100644
--- a/arch/arm/mach-mxs/include/mach/mx23.h
+++ b/arch/arm/mach-mxs/include/mach/mx23.h
@@ -93,7 +93,7 @@
 #define MX23_INT_USB_WAKEUP		12
 #define MX23_INT_GPMI_DMA		13
 #define MX23_INT_SSP1_DMA		14
-#define MX23_INT_SSP_ERROR		15
+#define MX23_INT_SSP1_ERROR		15
 #define MX23_INT_GPIO0			16
 #define MX23_INT_GPIO1			17
 #define MX23_INT_GPIO2			18
diff --git a/arch/arm/mach-mxs/include/mach/mx28.h b/arch/arm/mach-mxs/include/mach/mx28.h
index 3f3485a..75d8611 100644
--- a/arch/arm/mach-mxs/include/mach/mx28.h
+++ b/arch/arm/mach-mxs/include/mach/mx28.h
@@ -163,10 +163,10 @@
 #define MX28_INT_USB0			93
 #define MX28_INT_USB1_WAKEUP		94
 #define MX28_INT_USB0_WAKEUP		95
-#define MX28_INT_SSP0			96
-#define MX28_INT_SSP1			97
-#define MX28_INT_SSP2			98
-#define MX28_INT_SSP3			99
+#define MX28_INT_SSP0_ERROR		96
+#define MX28_INT_SSP1_ERROR		97
+#define MX28_INT_SSP2_ERROR		98
+#define MX28_INT_SSP3_ERROR		99
 #define MX28_INT_ENET_SWI		100
 #define MX28_INT_ENET_MAC0		101
 #define MX28_INT_ENET_MAC1		102
-- 
1.7.1
