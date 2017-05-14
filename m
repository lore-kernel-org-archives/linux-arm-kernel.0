From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 14 May 2017 04:24:26 +0200
Subject: [PATCH v3 2/5] dt-bindings: arm: Add Realtek RTD1295 bindings
In-Reply-To: <20170514022429.11555-1-afaerber@suse.de>
References: <20170514022429.11555-1-afaerber@suse.de>
Message-ID: <20170514022429.11555-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Zidoo X9S and a few other recent TV boxes feature the Realtek RTD1295,
a quad-core ARM Cortex-A53 SoC.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Roc He <hepeng@zidoo.tv>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2 -> v3: unchanged
 
 v1 -> v2:
 * Changed subject
 * Extended commit message
 * Clarified wording
 
 Documentation/devicetree/bindings/arm/realtek.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/realtek.txt

diff --git a/Documentation/devicetree/bindings/arm/realtek.txt b/Documentation/devicetree/bindings/arm/realtek.txt
new file mode 100644
index 000000000000..13d755787b4f
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/realtek.txt
@@ -0,0 +1,20 @@
+Realtek platforms device tree bindings
+--------------------------------------
+
+
+RTD1295 SoC
+===========
+
+Required root node properties:
+
+ - compatible :  must contain "realtek,rtd1295"
+
+
+Root node property compatible must contain, depending on board:
+
+ - Zidoo X9S: "zidoo,x9s"
+
+
+Example:
+
+    compatible = "zidoo,x9s", "realtek,rtd1295";
-- 
2.12.0
