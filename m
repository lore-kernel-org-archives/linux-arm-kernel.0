From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 19 Dec 2012 10:18:38 -0800
Subject: [PATCH v2 3/7] arm: zynq: timer: Remove unused #defines
In-Reply-To: <ab760e55-61c2-46b0-b899-1935c213536e@CO1EHSMHS026.ehs.local>
References: <ab760e55-61c2-46b0-b899-1935c213536e@CO1EHSMHS026.ehs.local>
Message-ID: <31c26534-3353-47aa-acd5-f320b04e76c6@VA3EHSMHS016.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Acked-by: Michal Simek <michal.simek@xilinx.com>
Acked-by: John Linn <john.linn@xilinx.com>
Reviewed-by: Josh Cartwright <josh.cartwright@ni.com>
---
 arch/arm/mach-zynq/timer.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-zynq/timer.c b/arch/arm/mach-zynq/timer.c
index f1d224b..80bf474 100644
--- a/arch/arm/mach-zynq/timer.c
+++ b/arch/arm/mach-zynq/timer.c
@@ -39,9 +39,6 @@
 #define XTTCPS_CNT_CNTRL_OFFSET	0x0C /* Counter Control Reg, RW */
 #define XTTCPS_COUNT_VAL_OFFSET	0x18 /* Counter Value Reg, RO */
 #define XTTCPS_INTR_VAL_OFFSET		0x24 /* Interval Count Reg, RW */
-#define XTTCPS_MATCH_1_OFFSET		0x30 /* Match 1 Value Reg, RW */
-#define XTTCPS_MATCH_2_OFFSET		0x3C /* Match 2 Value Reg, RW */
-#define XTTCPS_MATCH_3_OFFSET		0x48 /* Match 3 Value Reg, RW */
 #define XTTCPS_ISR_OFFSET		0x54 /* Interrupt Status Reg, RO */
 #define XTTCPS_IER_OFFSET		0x60 /* Interrupt Enable Reg, RW */
 
-- 
1.8.0.2
