From: weiyi.lu@mediatek.com (Weiyi Lu)
Date: Thu, 20 Sep 2018 17:57:25 +0800
Subject: [PATCH v1 1/3] dt-bindings: clock: add clock for MT2712
In-Reply-To: <20180920095727.11868-1-weiyi.lu@mediatek.com>
References: <20180920095727.11868-1-weiyi.lu@mediatek.com>
Message-ID: <20180920095727.11868-3-weiyi.lu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new clock according to 3rd ECO design change.
It's the parent clock of audio clock mux.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 include/dt-bindings/clock/mt2712-clk.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/mt2712-clk.h b/include/dt-bindings/clock/mt2712-clk.h
index 76265836a1e1..c3b29dff9c0e 100644
--- a/include/dt-bindings/clock/mt2712-clk.h
+++ b/include/dt-bindings/clock/mt2712-clk.h
@@ -228,7 +228,8 @@
 #define CLK_TOP_NFI2X_EN		189
 #define CLK_TOP_NFIECC_EN		190
 #define CLK_TOP_NFI1X_CK_EN		191
-#define CLK_TOP_NR_CLK			192
+#define CLK_TOP_APLL2_D3		192
+#define CLK_TOP_NR_CLK			193
 
 /* INFRACFG */
 
-- 
2.12.5.2.gbdf23ab
