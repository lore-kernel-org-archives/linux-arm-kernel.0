From: weiyi.lu@mediatek.com (Weiyi Lu)
Date: Mon, 12 Mar 2018 15:03:40 +0800
Subject: [PATCH v2 3/5] dt-bindings: clock: add clocks for MT2712
In-Reply-To: <20180312070342.4335-1-weiyi.lu@mediatek.com>
References: <20180312070342.4335-1-weiyi.lu@mediatek.com>
Message-ID: <20180312070342.4335-5-weiyi.lu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add new clocks according to ECO design change

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 include/dt-bindings/clock/mt2712-clk.h | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/clock/mt2712-clk.h b/include/dt-bindings/clock/mt2712-clk.h
index 48a8e797a617..76265836a1e1 100644
--- a/include/dt-bindings/clock/mt2712-clk.h
+++ b/include/dt-bindings/clock/mt2712-clk.h
@@ -222,7 +222,13 @@
 #define CLK_TOP_APLL_DIV_PDN5		183
 #define CLK_TOP_APLL_DIV_PDN6		184
 #define CLK_TOP_APLL_DIV_PDN7		185
-#define CLK_TOP_NR_CLK			186
+#define CLK_TOP_APLL1_D3		186
+#define CLK_TOP_APLL1_REF_SEL		187
+#define CLK_TOP_APLL2_REF_SEL		188
+#define CLK_TOP_NFI2X_EN		189
+#define CLK_TOP_NFIECC_EN		190
+#define CLK_TOP_NFI1X_CK_EN		191
+#define CLK_TOP_NR_CLK			192
 
 /* INFRACFG */
 
@@ -281,7 +287,9 @@
 #define CLK_PERI_MSDC30_3_EN		41
 #define CLK_PERI_MSDC50_0_HCLK_EN	42
 #define CLK_PERI_MSDC50_3_HCLK_EN	43
-#define CLK_PERI_NR_CLK			44
+#define CLK_PERI_MSDC30_0_QTR_EN	44
+#define CLK_PERI_MSDC30_3_QTR_EN	45
+#define CLK_PERI_NR_CLK			46
 
 /* MCUCFG */
 
-- 
2.12.5
