From: bhaskar.upadhaya@nxp.com (Bhaskar Upadhaya)
Date: Wed, 14 Nov 2018 05:30:50 +0000
Subject: [PATCH v3 1/2] dt-bindings: Add compatible string for LS1028A-QDS
Message-ID: <1542156591-3224-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sudhanshu Gupta <sudhanshu.gupta@nxp.com>
Signed-off-by: Rai Harninder <harninder.rai@nxp.com>
Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 changes in v3:
  no change

 Documentation/devicetree/bindings/arm/fsl.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index a6e0471..b2f20ede 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -168,6 +168,18 @@ LS1012A ARMv8 based QDS Board
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
