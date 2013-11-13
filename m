From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed, 13 Nov 2013 07:10:26 +0100
Subject: [PATCH v5 10/17] clk: at91: add peripheral clk macros for peripheral
 clk dt bindings
In-Reply-To: <1384289513-3068-1-git-send-email-b.brezillon@overkiz.com>
References: <1384289513-3068-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1384323026-5294-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the peripheral divisors macros (for sam9x5 compatible IPs)
which will be used by peripheral clk dt definitions.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 include/dt-bindings/clk/at91.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/dt-bindings/clk/at91.h b/include/dt-bindings/clk/at91.h
index 0b4cb99..a3b07ca 100644
--- a/include/dt-bindings/clk/at91.h
+++ b/include/dt-bindings/clk/at91.h
@@ -19,4 +19,10 @@
 #define AT91_PMC_MOSCRCS	17		/* Main On-Chip RC */
 #define AT91_PMC_CFDEV		18		/* Clock Failure Detector Event */
 
+/* sam9x5 peripheral divisors */
+#define AT91SAM9X5_PERIPH_CLK_DIV1	0
+#define AT91SAM9X5_PERIPH_CLK_DIV2	1
+#define AT91SAM9X5_PERIPH_CLK_DIV4	2
+#define AT91SAM9X5_PERIPH_CLK_DIV8	3
+
 #endif
-- 
1.7.9.5
