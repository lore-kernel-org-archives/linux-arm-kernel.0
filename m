From: prakity@marvell.com (Philip Rakity)
Date: Sun, 13 Feb 2011 22:49:37 -0800
Subject: [PATCH 1/5] arm: mach-mmp: SDH register definitions for (pxa168,
	pxa910, mmp2)
Message-ID: <E7516703-3A5B-4514-870E-12EFD6A218AA@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Register definitions added for APMU registers for all platforms
Definitions are platform dependent (not same for pxa168, pxz910, mmp2).

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/mach-mmp/include/mach/regs-apmu.h |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/regs-apmu.h b/arch/arm/mach-mmp/include/mach/regs-apmu.h
index f7011ef..9d1146f 100644
--- a/arch/arm/mach-mmp/include/mach/regs-apmu.h
+++ b/arch/arm/mach-mmp/include/mach/regs-apmu.h
@@ -20,15 +20,25 @@
 #define APMU_IRE	APMU_REG(0x048)
 #define APMU_LCD	APMU_REG(0x04c)
 #define APMU_CCIC	APMU_REG(0x050)
-#define APMU_SDH0	APMU_REG(0x054)
-#define APMU_SDH1	APMU_REG(0x058)
 #define APMU_USB	APMU_REG(0x05c)
 #define APMU_NAND	APMU_REG(0x060)
 #define APMU_DMA	APMU_REG(0x064)
 #define APMU_GEU	APMU_REG(0x068)
 #define APMU_BUS	APMU_REG(0x06c)
-#define APMU_SDH2	APMU_REG(0x0e8)
-#define APMU_SDH3	APMU_REG(0x0ec)
+
+#define APMU_PXA168_SDH0	APMU_REG(0x054)
+#define APMU_PXA168_SDH1	APMU_REG(0x058)
+#define APMU_PXA168_SDH2	APMU_REG(0x0e0)
+#define APMU_PXA168_SDH3	APMU_REG(0x0e4)
+
+#define APMU_PXA910_SDH0	APMU_REG(0x054)
+#define APMU_PXA910_SDH1	APMU_REG(0x058)
+#define APMU_PXA910_SDH2	APMU_REG(0x0e0)
+
+#define APMU_MMP2_SDH0	APMU_REG(0x054)
+#define APMU_MMP2_SDH1	APMU_REG(0x058)
+#define APMU_MMP2_SDH2	APMU_REG(0x0e8)
+#define APMU_MMP2_SDH3	APMU_REG(0x0ec)
 
 #define APMU_FNCLK_EN	(1 << 4)
 #define APMU_AXICLK_EN	(1 << 3)
-- 
1.7.0.4
