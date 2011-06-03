From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 3 Jun 2011 11:07:54 -0300
Subject: [PATCH] ARM: mx53: Fix IOMUX definitions for PATA_D6
Message-ID: <1307110074-11999-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Signed-off-by: Dinh Nguyen <dinh.nguyen@freescale.com>
---
 arch/arm/plat-mxc/include/mach/iomux-mx53.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx53.h b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
index e95d9cb..50b88a4 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx53.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
@@ -958,12 +958,12 @@
 #define _MX53_PAD_PATA_DATA5__ESDHC4_DAT5		IOMUX_PAD(0x63C, 0x2B8, 4, 0x0, 0, 0)
 #define _MX53_PAD_PATA_DATA5__GPU3d_GPU_DEBUG_OUT_5	IOMUX_PAD(0x63C, 0x2B8, 5, 0x0, 0, 0)
 #define _MX53_PAD_PATA_DATA5__IPU_DIAG_BUS_5	IOMUX_PAD(0x63C, 0x2B8, 6, 0x0, 0, 0)
-#define _MX53_PAD_PATA_DATA6__PATA_DATA_6	IOMUX_PAD(0x640, 0x2BC, 1, 0x0, 0, 0)
+#define _MX53_PAD_PATA_DATA6__PATA_DATA_6	IOMUX_PAD(0x640, 0x2BC, 0, 0x0, 0, 0)
 #define _MX53_PAD_PATA_DATA6__GPIO2_6		IOMUX_PAD(0x640, 0x2BC, 1, 0x0, 0, 0)
-#define _MX53_PAD_PATA_DATA6__EMI_NANDF_D_6	IOMUX_PAD(0x640, 0x2BC, 1, 0x0, 0, 0)
-#define _MX53_PAD_PATA_DATA6__ESDHC4_DAT6		IOMUX_PAD(0x640, 0x2BC, 1, 0x0, 0, 0)
-#define _MX53_PAD_PATA_DATA6__GPU3d_GPU_DEBUG_OUT_6	IOMUX_PAD(0x640, 0x2BC, 1, 0x0, 0, 0)
-#define _MX53_PAD_PATA_DATA6__IPU_DIAG_BUS_6	IOMUX_PAD(0x640, 0x2BC, 1, 0x0, 0, 0)
+#define _MX53_PAD_PATA_DATA6__EMI_NANDF_D_6	IOMUX_PAD(0x640, 0x2BC, 3, 0x0, 0, 0)
+#define _MX53_PAD_PATA_DATA6__ESDHC4_DAT6		IOMUX_PAD(0x640, 0x2BC, 4, 0x0, 0, 0)
+#define _MX53_PAD_PATA_DATA6__GPU3d_GPU_DEBUG_OUT_6	IOMUX_PAD(0x640, 0x2BC, 5, 0x0, 0, 0)
+#define _MX53_PAD_PATA_DATA6__IPU_DIAG_BUS_6	IOMUX_PAD(0x640, 0x2BC, 6, 0x0, 0, 0)
 #define _MX53_PAD_PATA_DATA7__PATA_DATA_7		IOMUX_PAD(0x644, 0x2C0, 0, 0x0, 0, 0)
 #define _MX53_PAD_PATA_DATA7__GPIO2_7		IOMUX_PAD(0x644, 0x2C0, 1, 0x0, 0, 0)
 #define _MX53_PAD_PATA_DATA7__EMI_NANDF_D_7	IOMUX_PAD(0x644, 0x2C0, 3, 0x0, 0, 0)
-- 
1.6.0.4
