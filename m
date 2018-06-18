From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Mon, 18 Jun 2018 16:58:26 +0200
Subject: [PATCH v4 02/19] dt-bindings: sram: sunxi: Add A10 binding for the C1
 SRAM region
In-Reply-To: <20180618145843.14631-1-paul.kocialkowski@bootlin.com>
References: <20180618145843.14631-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180618145843.14631-3-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces a dedicated binding for the C1 SRAM region for the A10
sunxi platform.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

diff --git a/Documentation/devicetree/bindings/sram/sunxi-sram.txt b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
index 19cc0b892672..5af5bafd5572 100644
--- a/Documentation/devicetree/bindings/sram/sunxi-sram.txt
+++ b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
@@ -29,6 +29,7 @@ once again the representation described in the mmio-sram binding.
 
 The valid sections compatible for A10 are:
     - allwinner,sun4i-a10-sram-a3-a4
+    - allwinner,sun4i-a10-sram-c1
     - allwinner,sun4i-a10-sram-d
 
 The valid sections compatible for A64 are:
-- 
2.17.0
