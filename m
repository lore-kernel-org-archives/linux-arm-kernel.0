From: Zhiqiang.Hou@freescale.com (Zhiqiang Hou)
Date: Thu, 24 Dec 2015 17:37:51 +0800
Subject: [PATCH v9 1/3] Documentation: DT: Add entry for Freescale LS1043a-RDB
 board
Message-ID: <1450949873-34260-1-git-send-email-Zhiqiang.Hou@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mingkai Hu <Mingkai.Hu@freescale.com>

Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
---
V9 - V2:
 - No change.
 Documentation/devicetree/bindings/arm/fsl.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 34c88b0..752a685 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -131,6 +131,10 @@ Example:
 Freescale ARMv8 based Layerscape SoC family Device Tree Bindings
 ----------------------------------------------------------------
 
+LS1043A ARMv8 based RDB Board
+Required root node properties:
+    - compatible = "fsl,ls1043a-rdb", "fsl,ls1043a";
+
 LS2080A ARMv8 based Simulator model
 Required root node properties:
     - compatible = "fsl,ls2080a-simu", "fsl,ls2080a";
-- 
2.1.0.27.g96db324
