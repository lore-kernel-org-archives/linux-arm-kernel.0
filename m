From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 19 Dec 2012 10:18:39 -0800
Subject: [PATCH v2 4/7] arm: zynq: timer: Align columns
In-Reply-To: <ab760e55-61c2-46b0-b899-1935c213536e@CO1EHSMHS026.ehs.local>
References: <ab760e55-61c2-46b0-b899-1935c213536e@CO1EHSMHS026.ehs.local>
Message-ID: <6707a3e2-3f76-40cb-a752-b37d0c7d2da6@VA3EHSMHS038.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aligning the columns in a block of #defines, so that the values
are starting in the same colum on every line.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Reviewed-by: Josh Cartwright <josh.cartwright@ni.com>
---
 arch/arm/mach-zynq/timer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-zynq/timer.c b/arch/arm/mach-zynq/timer.c
index 80bf474..4b81ae1 100644
--- a/arch/arm/mach-zynq/timer.c
+++ b/arch/arm/mach-zynq/timer.c
@@ -35,9 +35,9 @@
  * Timer Register Offset Definitions of Timer 1, Increment base address by 4
  * and use same offsets for Timer 2
  */
-#define XTTCPS_CLK_CNTRL_OFFSET	0x00 /* Clock Control Reg, RW */
-#define XTTCPS_CNT_CNTRL_OFFSET	0x0C /* Counter Control Reg, RW */
-#define XTTCPS_COUNT_VAL_OFFSET	0x18 /* Counter Value Reg, RO */
+#define XTTCPS_CLK_CNTRL_OFFSET		0x00 /* Clock Control Reg, RW */
+#define XTTCPS_CNT_CNTRL_OFFSET		0x0C /* Counter Control Reg, RW */
+#define XTTCPS_COUNT_VAL_OFFSET		0x18 /* Counter Value Reg, RO */
 #define XTTCPS_INTR_VAL_OFFSET		0x24 /* Interval Count Reg, RW */
 #define XTTCPS_ISR_OFFSET		0x54 /* Interrupt Status Reg, RO */
 #define XTTCPS_IER_OFFSET		0x60 /* Interrupt Enable Reg, RW */
-- 
1.8.0.2
