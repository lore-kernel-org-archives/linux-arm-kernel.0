From: mesihkilinc@gmail.com (Mesih Kilinc)
Date: Sun, 25 Nov 2018 10:43:17 +0300
Subject: [RFC PATCH v4 14/17] dt-bindings: sram: Add Allwinner suniv F1C100s
In-Reply-To: <cover.1543131714.git.mesihkilinc@gmail.com>
References: <cover.1543131714.git.mesihkilinc@gmail.com>
Message-ID: <f80ca2de497c44c9415b02ac9aba93721d723730.1543131714.git.mesihkilinc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The suniv ARMv5 F1C100s chip has similar sram controller to sun4i A10.
Add compatible string for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 Documentation/devicetree/bindings/sram/sunxi-sram.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sram/sunxi-sram.txt b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
index 62dd074..5c84850 100644
--- a/Documentation/devicetree/bindings/sram/sunxi-sram.txt
+++ b/Documentation/devicetree/bindings/sram/sunxi-sram.txt
@@ -19,6 +19,7 @@ Required properties:
     - "allwinner,sun50i-a64-sram-controller" (deprecated)
     - "allwinner,sun50i-a64-system-control"
     - "allwinner,sun50i-h6-system-control", "allwinner,sun50i-a64-system-control"
+    - "allwinner,suniv-f1c100s-system-control", "allwinner,sun4i-a10-system-control"
 - reg : sram controller register offset + length
 
 SRAM nodes
@@ -58,6 +59,9 @@ The valid sections compatible for A64 are:
 The valid sections compatible for H6 are:
     - allwinner,sun50i-h6-sram-c, allwinner,sun50i-a64-sram-c
 
+The valid sections compatible for F1C100s are:
+    - allwinner,suniv-f1c100s-sram-d, allwinner,sun4i-a10-sram-d
+
 Devices using SRAM sections
 ---------------------------
 
-- 
2.7.4
