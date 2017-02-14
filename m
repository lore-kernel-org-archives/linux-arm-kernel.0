From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 14 Feb 2017 11:35:24 +0800
Subject: [PATCH 3/5] clk: sunxi-ng: Add compatible string for A83T CCU to
 bindings
In-Reply-To: <20170214033526.16977-1-wens@csie.org>
References: <20170214033526.16977-1-wens@csie.org>
Message-ID: <20170214033526.16977-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T clock control unit is a hybrid of some new style clock designs
from the A80, and old style layout from the other Allwinner SoCs.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/clock/sunxi-ccu.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
index bae5668cf427..a6144f913f17 100644
--- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
+++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
@@ -6,6 +6,7 @@ Required properties :
 		- "allwinner,sun6i-a31-ccu"
 		- "allwinner,sun8i-a23-ccu"
 		- "allwinner,sun8i-a33-ccu"
+		- "allwinner,sun8i-a83t-ccu"
 		- "allwinner,sun8i-h3-ccu"
 		- "allwinner,sun8i-v3s-ccu"
 		- "allwinner,sun9i-a80-ccu"
-- 
2.11.0
