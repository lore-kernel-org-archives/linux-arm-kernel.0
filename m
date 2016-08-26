From: Bhaskar.Upadhaya@nxp.com (Bhaskar Upadhaya)
Date: Fri, 26 Aug 2016 15:57:40 +0530
Subject: [PATCH 01/10] dt-bindings: Add compatible property for LS1012A
Message-ID: <1472207269-18499-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index dbbc095..51b6b03 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -119,7 +119,7 @@ Freescale DCFG
 configuration and status for the device. Such as setting the secondary
 core start address and release the secondary core from holdoff and startup.
   Required properties:
-  - compatible: should be "fsl,ls1021a-dcfg"
+  - compatible: can be "fsl,ls1021a-dcfg", "fsl,ls1012a-dcfg", "fsl,ls1043a-dcfg"
   - reg : should contain base address and length of DCFG memory-mapped registers
 
 Example:
@@ -151,3 +151,14 @@ LS2080A ARMv8 based RDB Board
 Required root node properties:
     - compatible = "fsl,ls2080a-rdb", "fsl,ls2080a";
 
+LS1012A ARMv8 based FRDM Board
+Required root node properties:
+    - compatible = "fsl,ls1012a-frdm", "fsl,ls1012a";
+
+LS1012A ARMv8 based RDB Board
+Required root node properties:
+    - compatible = "fsl,ls1012a-rdb", "fsl,ls1012a";
+
+LS1012A ARMv8 based QDS Board
+Required root node properties:
+    - compatible = "fsl,ls1012a-qds", "fsl,ls1012a";
-- 
1.9.1
