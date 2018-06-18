From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Mon, 18 Jun 2018 16:58:25 +0200
Subject: [PATCH v4 01/19] dt-bindings: sram: sunxi: Add A13,
 A20 and A33 SRAM controller bindings
In-Reply-To: <20180618145843.14631-1-paul.kocialkowski@bootlin.com>
References: <20180618145843.14631-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180618145843.14631-2-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces dedicated bindings for the SRAM controllers found on the
A13, A20 and A33 sunxi platforms.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

diff --git a/Documentation/devicetree/bindings/sram/sunxi-sram.txt b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
index d087f04a4d7f..19cc0b892672 100644
--- a/Documentation/devicetree/bindings/sram/sunxi-sram.txt
+++ b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
@@ -11,6 +11,9 @@ Controller Node
 Required properties:
 - compatible : should be:
     - "allwinner,sun4i-a10-sram-controller"
+    - "allwinner,sun5i-a13-sram-controller"
+    - "allwinner,sun7i-a20-sram-controller"
+    - "allwinner,sun8i-a33-sram-controller"
     - "allwinner,sun50i-a64-sram-controller"
 - reg : sram controller register offset + length
 
-- 
2.17.0
