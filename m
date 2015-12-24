From: Zhiqiang.Hou@freescale.com (Zhiqiang Hou)
Date: Thu, 24 Dec 2015 17:11:37 +0800
Subject: [PATCH v2 1/2] Documentation: DT: Add entry for Freescale LS1043a-QDS
 board
Message-ID: <1450948298-33238-1-git-send-email-Zhiqiang.Hou@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@freescale.com>

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@freescale.com>
---
new patch

 Documentation/devicetree/bindings/arm/fsl.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 752a685..dbbc095 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -135,6 +135,10 @@ LS1043A ARMv8 based RDB Board
 Required root node properties:
     - compatible = "fsl,ls1043a-rdb", "fsl,ls1043a";
 
+LS1043A ARMv8 based QDS Board
+Required root node properties:
+    - compatible = "fsl,ls1043a-qds", "fsl,ls1043a";
+
 LS2080A ARMv8 based Simulator model
 Required root node properties:
     - compatible = "fsl,ls2080a-simu", "fsl,ls2080a";
-- 
2.1.0.27.g96db324
