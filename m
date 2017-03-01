From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu,  2 Mar 2017 02:01:10 +0800
Subject: [PATCH v2 4/5] dt: bindings: add binding for Allwinner A64 R_PIO
 pinctrl
In-Reply-To: <20170301180111.12365-1-icenowy@aosc.xyz>
References: <20170301180111.12365-1-icenowy@aosc.xyz>
Message-ID: <20170301180111.12365-5-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64 SoC has also a dedicated pin controller for Port L GPIOs,
which is called "Port Controller (CPUs-PORT)" in SoC User Manual.

Add a binding for this pin controller, like the ones in A23/33 and H3.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
index 8177bb4d5f53..b53224473672 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
@@ -23,6 +23,7 @@ Required properties:
   "allwinner,sun8i-h3-pinctrl"
   "allwinner,sun8i-h3-r-pinctrl"
   "allwinner,sun50i-a64-pinctrl"
+  "allwinner,sun50i-a64-r-pinctrl"
   "allwinner,sun50i-h5-pinctrl"
   "nextthing,gr8-pinctrl"
 
-- 
2.11.1
