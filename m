From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu,  8 Aug 2013 08:09:20 +0200
Subject: [PATCH v3 07/19] clk: at91: add pll id macros for pll dt bindings
In-Reply-To: <1375937608-3773-1-git-send-email-b.brezillon@overkiz.com>
References: <1375937608-3773-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1375942160-8881-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the PLL id macros which will be used by pll dt definitions.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 include/dt-bindings/clk/at91/common/clk-pll.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)
 create mode 100644 include/dt-bindings/clk/at91/common/clk-pll.h

diff --git a/include/dt-bindings/clk/at91/common/clk-pll.h b/include/dt-bindings/clk/at91/common/clk-pll.h
new file mode 100644
index 0000000..93ec849
--- /dev/null
+++ b/include/dt-bindings/clk/at91/common/clk-pll.h
@@ -0,0 +1,13 @@
+/*
+ * This header provides constants for AT91 pll ids.
+ *
+ * The constants defined in this header are being used in dts.
+ */
+
+#ifndef _DT_BINDINGS_CLK_AT91_PLL_H
+#define _DT_BINDINGS_CLK_AT91_PLL_H
+
+#define AT91_PLLA_CLK		0	/* PLLA clk id */
+#define AT91_PLLB_CLK		1	/* PLLB clk id */
+
+#endif
-- 
1.7.9.5
