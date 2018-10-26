From: pramod.kumar_1@nxp.com (Pramod Kumar)
Date: Fri, 26 Oct 2018 08:45:26 +0000
Subject: [PATCH v2] dt-bindings: ls1012a: Add FRWY-LS1012A device tree binding
Message-ID: <20181026084554.32290-1-pramod.kumar_1@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LS1012A-FRWY is an ls1012a based SoC board
Add device tree binding for LS1012A-FRWY board

Signed-off-by: Pramod Kumar <pramod.kumar_1@nxp.com>
---
Change in v2:
-Change the subject line

 Documentation/devicetree/bindings/arm/fsl.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 8a1baa2b9723..1eda1f79eb43 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -155,6 +155,10 @@ LS1012A ARMv8 based FRDM Board
 Required root node properties:
     - compatible = "fsl,ls1012a-frdm", "fsl,ls1012a";
 
+LS1012A ARMv8 based FRWY Board
+Required root node properties:
+    - compatible = "fsl,ls1012a-frwy", "fsl,ls1012a";
+
 LS1012A ARMv8 based QDS Board
 Required root node properties:
     - compatible = "fsl,ls1012a-qds", "fsl,ls1012a";
-- 
2.17.1
