From: bhaskar.upadhaya@nxp.com (Bhaskar Upadhaya)
Date: Wed, 17 Oct 2018 11:49:48 +0000
Subject: [PATCH v2 2/2] dt-bindings: Add compatible string for LS1028A-QDS
In-Reply-To: <1539760132-3386-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
References: <1539760132-3386-1-git-send-email-Bhaskar.Upadhaya@nxp.com>
Message-ID: <1539760132-3386-2-git-send-email-Bhaskar.Upadhaya@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sudhanshu Gupta <sudhanshu.gupta@nxp.com>
Signed-off-by: Rai Harninder <harninder.rai@nxp.com>
Signed-off-by: Rajesh Bhagat <rajesh.bhagat@nxp.com>
Signed-off-by: Bhaskar Upadhaya <Bhaskar.Upadhaya@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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
