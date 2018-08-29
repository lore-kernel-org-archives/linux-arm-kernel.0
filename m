From: sudhanshu.gupta@nxp.com (Sudhanshu Gupta)
Date: Wed, 29 Aug 2018 20:47:26 +0530
Subject: [PATCH] dt-bindings: Add compatible string for LS1028A-QDS
Message-ID: <1535555846-7817-1-git-send-email-sudhanshu.gupta@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>

Signed-off-by: Sudhanshu Gupta <sudhanshu.gupta@nxp.com>
Signed-off-by: Rai Harninder <harninder.rai@nxp.com>
Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index ea08bf2..3e44804 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -163,6 +163,18 @@ LS1012A ARMv8 based QDS Board
 Required root node properties:
     - compatible = "fsl,ls1012a-qds", "fsl,ls1012a";
 
+LS1028A SoC
+Required root node properties:
+    - compatible = "fsl,ls1028a";
+
+LS1028A ARMv8 based RDB Board
+Required root node properties:
+    - compatible = "fsl,ls1028a-rdb", "fsl,ls1028a"
+
+LS1028A ARMv8 based QDS Board
+Required root node properties:
+    - compatible = "fsl,ls1028a-qds", "fsl,ls1028a";
+
 LS1043A SoC
 Required root node properties:
     - compatible = "fsl,ls1043a";
-- 
1.9.1
