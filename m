From: richard.zhao@freescale.com (Richard Zhao)
Date: Fri, 11 Feb 2011 18:22:10 +0800
Subject: [PATCH 1/2] arm: mx50_rdp: add fec support
Message-ID: <1297419731-16441-1-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>

diff --git a/arch/arm/mach-mx5/board-mx50_rdp.c b/arch/arm/mach-mx5/board-mx50_rdp.c
index dedf7f2..505513c 100644
--- a/arch/arm/mach-mx5/board-mx50_rdp.c
+++ b/arch/arm/mach-mx5/board-mx50_rdp.c
@@ -40,6 +40,9 @@
 #define FEC_EN		IMX_GPIO_NR(6, 23)
 #define FEC_RESET_B	IMX_GPIO_NR(4, 12)
 
+#define FEC_EN		IMX_GPIO_NR(6, 23)
+#define FEC_RESET_B	IMX_GPIO_NR(4, 12)
+
 static iomux_v3_cfg_t mx50_rdp_pads[] __initdata = {
 	/* SD1 */
 	MX50_PAD_ECSPI2_SS0__GPIO_4_19,
-- 
1.7.1
