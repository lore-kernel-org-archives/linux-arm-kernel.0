From: yong.shen@freescale.com (yong.shen at freescale.com)
Date: Thu, 13 Jan 2011 11:39:51 +0800
Subject: [PATCH v4 1/3] ARM: i.MX53: add IOMUX pad for ecspi
Message-ID: <1294889993-16347-1-git-send-email-yong.shen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yong Shen <yong.shen@freescale.com>

Add IOMUX pad entry for ecspi

Signed-off-by: Yong Shen <yong.shen@freescale.com>
---
 arch/arm/plat-mxc/include/mach/iomux-mx53.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-mxc/include/mach/iomux-mx53.h b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
index 2673007..68e11d7 100644
--- a/arch/arm/plat-mxc/include/mach/iomux-mx53.h
+++ b/arch/arm/plat-mxc/include/mach/iomux-mx53.h
@@ -134,6 +134,9 @@ typedef enum iomux_config {
 #define MX53_PAD_EIM_D16__GPIO_3_16		IOMUX_PAD(0x460, 0x118,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
 #define MX53_PAD_EIM_D17__GPIO_3_17		IOMUX_PAD(0x464, 0x11C,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
 #define MX53_PAD_EIM_D18__GPIO_3_18		IOMUX_PAD(0x468, 0x120,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
+#define MX53_PAD_EIM_D16__CSPI1_SCLK		IOMUX_PAD(0x460, 0x118,IOMUX_CONFIG_ALT4, 0x79c, 3, NO_PAD_CTRL)
+#define MX53_PAD_EIM_D17__CSPI1_MISO		IOMUX_PAD(0x464, 0x11C,IOMUX_CONFIG_ALT4, 0x7a0, 3, NO_PAD_CTRL)
+#define MX53_PAD_EIM_D18__CSPI1_MOSI		IOMUX_PAD(0x468, 0x120,IOMUX_CONFIG_ALT4, 0x7a4, 3, NO_PAD_CTRL)
 #define MX53_PAD_EIM_D19__GPIO_3_19		IOMUX_PAD(0x46C, 0x124,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
 #define MX53_PAD_EIM_D20__GPIO_3_20		IOMUX_PAD(0x470, 0x128,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
 #define MX53_PAD_EIM_D21__GPIO_3_21		IOMUX_PAD(0x474, 0x12C,IOMUX_CONFIG_ALT1, 0x0, 0, NO_PAD_CTRL)
-- 
1.7.1
