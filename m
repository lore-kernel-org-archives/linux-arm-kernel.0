From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri,  7 Nov 2014 11:57:50 +0000
Subject: [PATCH 08/13] ARM: STi: DT: STiH410: Add defines for STiH410 DT clocks
In-Reply-To: <1415361475-6218-1-git-send-email-peter.griffin@linaro.org>
References: <1415361475-6218-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1415361475-6218-9-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although most clock outputs are the same as stih407 SoC, stih410
also has some additional new clock outputs.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 include/dt-bindings/clock/stih410-clks.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 include/dt-bindings/clock/stih410-clks.h

diff --git a/include/dt-bindings/clock/stih410-clks.h b/include/dt-bindings/clock/stih410-clks.h
new file mode 100644
index 0000000..2c5d6ff
--- /dev/null
+++ b/include/dt-bindings/clock/stih410-clks.h
@@ -0,0 +1,24 @@
+/*
+ * This header provides constants clk index STMicroelectronics
+ * STiH410 SoC.
+ */
+#ifndef _DT_BINDINGS_CLK_STIH410
+#define _DT_BINDINGS_CLK_STIH410
+#include "stih407-clks.h"
+
+/* STiH410 introduces new clock outputs compared to STiH407 */
+
+/* CLOCKGEN C0 */
+#define CLK_TX_ICN_HADES	32
+#define CLK_RX_ICN_HADES	33
+#define CLK_ICN_REG_16		34
+#define CLK_PP_HADES		35
+#define CLK_CLUST_HADES		36
+#define CLK_HWPE_HADES		37
+#define CLK_FC_HADES		38
+
+/* CLOCKGEN D0 */
+#define CLK_PCMR10_MASTER	4
+#define CLK_USB2_PHY		5
+
+#endif
-- 
1.9.1
