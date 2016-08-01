From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Mon,  1 Aug 2016 22:59:38 +0800
Subject: [PATCH 1/2] dt: bindings: add binding for Allwinner A64 R_PIO pinctrl
Message-ID: <20160801145939.50583-1-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
index 6961722..ee73f9f 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
@@ -23,6 +23,7 @@ Required properties:
   "allwinner,sun8i-h3-pinctrl"
   "allwinner,sun8i-h3-r-pinctrl"
   "allwinner,sun50i-a64-pinctrl"
+  "allwinner,sun50i-a64-r-pinctrl"
 
 - reg: Should contain the register physical address and length for the
   pin controller.
-- 
2.9.0
