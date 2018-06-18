From: paul.kocialkowski@bootlin.com (Paul Kocialkowski)
Date: Mon, 18 Jun 2018 16:58:29 +0200
Subject: [PATCH v4 05/19] dt-bindings: sram: sunxi: Add A33 binding for the C1
 SRAM region
In-Reply-To: <20180618145843.14631-1-paul.kocialkowski@bootlin.com>
References: <20180618145843.14631-1-paul.kocialkowski@bootlin.com>
Message-ID: <20180618145843.14631-6-paul.kocialkowski@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This introduces a dedicated binding for the C1 SRAM region for the A33
sunxi platform.

Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

diff --git a/Documentation/devicetree/bindings/sram/sunxi-sram.txt b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
index 221fa7b42c18..d8d1aac0840b 100644
--- a/Documentation/devicetree/bindings/sram/sunxi-sram.txt
+++ b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
@@ -38,6 +38,9 @@ The valid sections compatible for A13 are:
 The valid sections compatible for A20 are:
     - allwinner,sun7i-a20-sram-c1
 
+The valid sections compatible for A33 are:
+    - allwinner,sun8i-a33-sram-c1
+
 The valid sections compatible for A64 are:
     - allwinner,sun50i-a64-sram-c
 
-- 
2.17.0
