From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 24 Nov 2017 23:47:39 +0300
Subject: [PATCH] arm64: renesas: document V3MSK board bindings
Message-ID: <20171124204748.920422106@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the V3M Starter Kit device tree bindings, listing it as
a supported board.

This allows to use checkpatch.pl to validate .dts files referring to
the V3MSK board.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 Documentation/devicetree/bindings/arm/shmobile.txt |    2 ++
 1 file changed, 2 insertions(+)

Index: renesas/Documentation/devicetree/bindings/arm/shmobile.txt
===================================================================
--- renesas.orig/Documentation/devicetree/bindings/arm/shmobile.txt
+++ renesas/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -112,6 +112,8 @@ Boards:
     compatible = "renesas,sk-rzg1e", "renesas,r8a7745"
   - SK-RZG1M (YR8A77430S000BE)
     compatible = "renesas,sk-rzg1m", "renesas,r8a7743"
+  - V3MSK
+    compatible = "renesas,v3msk", "renesas,r8a77970"
   - Wheat
     compatible = "renesas,wheat", "renesas,r8a7792"
 
