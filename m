From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 27 Apr 2018 16:14:44 +0800
Subject: [PATCH v2 3/6] dt-bindings: clock: mediatek: add entry for Mali-450
 node to refer
In-Reply-To: <cover.1524816502.git.sean.wang@mediatek.com>
References: <cover.1524816502.git.sean.wang@mediatek.com>
Message-ID: <082c3040e2be27d30e0642943f6df35ff4de5666.1524816502.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Just add binding for a required clock referenced by Mali-450 on MT7623
or MT2701 SoC.

Cc: devicetree at vger.kernel.org
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 include/dt-bindings/clock/mt2701-clk.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/mt2701-clk.h b/include/dt-bindings/clock/mt2701-clk.h
index 24e93df..2ac62a6 100644
--- a/include/dt-bindings/clock/mt2701-clk.h
+++ b/include/dt-bindings/clock/mt2701-clk.h
@@ -431,6 +431,10 @@
 #define CLK_ETHSYS_CRYPTO			8
 #define CLK_ETHSYS_NR				9
 
+/* G3DSYS */
+#define CLK_G3DSYS_CORE				1
+#define CLK_G3DSYS_NR				2
+
 /* BDP */
 
 #define CLK_BDP_BRG_BA				1
-- 
2.7.4
