From: harninder.rai@nxp.com (Harninder Rai)
Date: Wed, 9 Nov 2016 23:34:11 +0530
Subject: [PATCH 1/3] Documentation: DT: Add entry for FSL LS1012A RDB, FRDM,
 QDS boards
Message-ID: <1478714651-12679-1-git-send-email-harninder.rai@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Harninder Rai <harninder.rai@nxp.com>
Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index d6ee9c6..3b01338 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -139,6 +139,22 @@ Example:
 Freescale ARMv8 based Layerscape SoC family Device Tree Bindings
 ----------------------------------------------------------------
 
+LS1012A SoC
+Required root node properties:
+    - compatible = "fsl,ls1012a";
+
+LS1012A ARMv8 based RDB Board
+Required root node properties:
+    - compatible = "fsl,ls1012a-rdb", "fsl,ls1012a";
+
+LS1012A ARMv8 based FRDM Board
+Required root node properties:
+    - compatible = "fsl,ls1012a-frdm", "fsl,ls1012a";
+
+LS1012A ARMv8 based QDS Board
+Required root node properties:
+    - compatible = "fsl,ls1012a-qds", "fsl,ls1012a";
+
 LS1043A SoC
 Required root node properties:
     - compatible = "fsl,ls1043a";
-- 
2.7.4
