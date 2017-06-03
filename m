From: wens@csie.org (Chen-Yu Tsai)
Date: Sat,  3 Jun 2017 22:44:25 +0800
Subject: [PATCH 1/3] dt-bindings: pinctrl: sunxi: Add compatible string for
 A83T R_PIO
In-Reply-To: <20170603144427.22855-1-wens@csie.org>
References: <20170603144427.22855-1-wens@csie.org>
Message-ID: <20170603144427.22855-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R_PIO on the A83T is almost the same as the one found on the A64,
except that the CIR_RX function was moved from pin PL11 to pin PL12.

Add a compatible string for it.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
index 3ab9f7849a19..6f2ec9af0de2 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
@@ -20,6 +20,7 @@ Required properties:
   "allwinner,sun9i-a80-pinctrl"
   "allwinner,sun9i-a80-r-pinctrl"
   "allwinner,sun8i-a83t-pinctrl"
+  "allwinner,sun8i-a83t-r-pinctrl"
   "allwinner,sun8i-h3-pinctrl"
   "allwinner,sun8i-h3-r-pinctrl"
   "allwinner,sun8i-r40-pinctrl"
-- 
2.11.0
