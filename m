From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  6 Jun 2017 02:54:00 +0200
Subject: [PATCH v4 02/28] dt-bindings: arm: Document Actions Semi S500
In-Reply-To: <20170606005426.26446-1-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
Message-ID: <20170606005426.26446-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Actions Semi S500 is a quad-core ARM Cortex-A9 SoC.
The LeMaker Guitar is an SODIMM-format module with that SoC.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2 -> v3 -> v4: unchanged
 
 v1 -> v2:
 * Adopted "actions" vendor prefix
 * Extended text
 
 Documentation/devicetree/bindings/arm/actions.txt | 24 +++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/actions.txt

diff --git a/Documentation/devicetree/bindings/arm/actions.txt b/Documentation/devicetree/bindings/arm/actions.txt
new file mode 100644
index 000000000000..1d3782e41b00
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/actions.txt
@@ -0,0 +1,24 @@
+Actions Semi platforms device tree bindings
+-------------------------------------------
+
+
+S500 SoC
+========
+
+Required root node properties:
+
+ - compatible :  must contain "actions,s500"
+
+
+Modules:
+
+Root node property compatible must contain, depending on module:
+
+ - LeMaker Guitar: "lemaker,guitar"
+
+
+Boards:
+
+Root node property compatible must contain, depending on board:
+
+ - LeMaker Guitar Base Board rev. B: "lemaker,guitar-bb-rev-b", "lemaker,guitar"
-- 
2.12.3
