From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Mon, 7 Mar 2016 19:30:31 +0800
Subject: [PATCH v3 1/2] Documentation: DT: Add entry for Freescale LS1043a-QDS
 board
Message-ID: <1457350232-12749-1-git-send-email-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
v3:
 - No change.

 Documentation/devicetree/bindings/arm/fsl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 752a685..f504fdf 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -134,6 +134,7 @@ Freescale ARMv8 based Layerscape SoC family Device Tree Bindings
 LS1043A ARMv8 based RDB Board
 Required root node properties:
     - compatible = "fsl,ls1043a-rdb", "fsl,ls1043a";
+    - compatible = "fsl,ls1043a-qds", "fsl,ls1043a";
 
 LS2080A ARMv8 based Simulator model
 Required root node properties:
-- 
2.1.0.27.g96db324
