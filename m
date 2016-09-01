From: chris.brandt@renesas.com (Chris Brandt)
Date: Thu,  1 Sep 2016 11:54:28 -0400
Subject: [PATCH 1/3] ARM: dts: r7s72100: add ethernet clock to device tree
Message-ID: <20160901155430.23400-1-chris.brandt@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 include/dt-bindings/clock/r7s72100-clock.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/clock/r7s72100-clock.h b/include/dt-bindings/clock/r7s72100-clock.h
index 5128f4d..3cd8138 100644
--- a/include/dt-bindings/clock/r7s72100-clock.h
+++ b/include/dt-bindings/clock/r7s72100-clock.h
@@ -25,6 +25,9 @@
 #define R7S72100_CLK_SCIF6	1
 #define R7S72100_CLK_SCIF7	0
 
+/* MSTP7 */
+#define R7S72100_CLK_ETHER	4
+
 /* MSTP9 */
 #define R7S72100_CLK_I2C0	7
 #define R7S72100_CLK_I2C1	6
-- 
2.9.2
