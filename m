From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 11 Dec 2013 14:33:13 +0200
Subject: [PATCH] dt-bindings: fix example of allwinner interrupt controller
Message-ID: <bce591494e52baf5571db0c9a5a26d33d018fe49.1386765193.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The documented value of #interrupt-cells is 1.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 .../devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
index 3d3b2b9..32cec4b 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-ic.txt
@@ -14,5 +14,5 @@ intc: interrupt-controller {
 	compatible = "allwinner,sun4i-ic";
 	reg = <0x01c20400 0x400>;
 	interrupt-controller;
-	#interrupt-cells = <2>;
+	#interrupt-cells = <1>;
 };
-- 
1.8.5.1
