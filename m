From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 25 Aug 2011 08:52:36 -0300
Subject: [PATCH] ARM: imx: Remove unused chip revision strings
Message-ID: <1314273156-14916-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit (167a19d2: ARM: imx: Introduce generic function for displaying silicon revision)
we no longer need the chip revision strings, so remove them.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/plat-mxc/include/mach/mxc.h |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
index 0987923..ea28170 100644
--- a/arch/arm/plat-mxc/include/mach/mxc.h
+++ b/arch/arm/plat-mxc/include/mach/mxc.h
@@ -50,20 +50,6 @@
 #define IMX_CHIP_REVISION_3_3		0x33
 #define IMX_CHIP_REVISION_UNKNOWN	0xff
 
-#define IMX_CHIP_REVISION_1_0_STRING		"1.0"
-#define IMX_CHIP_REVISION_1_1_STRING		"1.1"
-#define IMX_CHIP_REVISION_1_2_STRING		"1.2"
-#define IMX_CHIP_REVISION_1_3_STRING		"1.3"
-#define IMX_CHIP_REVISION_2_0_STRING		"2.0"
-#define IMX_CHIP_REVISION_2_1_STRING		"2.1"
-#define IMX_CHIP_REVISION_2_2_STRING		"2.2"
-#define IMX_CHIP_REVISION_2_3_STRING		"2.3"
-#define IMX_CHIP_REVISION_3_0_STRING		"3.0"
-#define IMX_CHIP_REVISION_3_1_STRING		"3.1"
-#define IMX_CHIP_REVISION_3_2_STRING		"3.2"
-#define IMX_CHIP_REVISION_3_3_STRING		"3.3"
-#define IMX_CHIP_REVISION_UNKNOWN_STRING	"unknown"
-
 #ifndef __ASSEMBLY__
 extern unsigned int __mxc_cpu_type;
 #endif
-- 
1.6.0.4
