From: shh.xie@gmail.com (shh.xie at gmail.com)
Date: Tue, 13 Sep 2016 16:09:54 +0800
Subject: [PATCH 01/10] [v3] dt-bindings: fsl: update for more SoCs
In-Reply-To: <1473754203-22970-1-git-send-email-shh.xie@gmail.com>
References: <1473754203-22970-1-git-send-email-shh.xie@gmail.com>
Message-ID: <1473754203-22970-2-git-send-email-shh.xie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shaohui Xie <Shaohui.Xie@nxp.com>

Adds SoC compatible for LS1043A and LS2080A which are supported, and
for LS1046A which is going to be supported.

Signed-off-by: Shaohui Xie <Shaohui.Xie@nxp.com>
---
changes in V3:
1. new patch.

 Documentation/devicetree/bindings/arm/fsl.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index dbbc095..2efbc09 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -131,6 +131,10 @@ Example:
 Freescale ARMv8 based Layerscape SoC family Device Tree Bindings
 ----------------------------------------------------------------
 
+LS1043A SoC
+Required root node properties:
+    - compatible = "fsl,ls1043a";
+
 LS1043A ARMv8 based RDB Board
 Required root node properties:
     - compatible = "fsl,ls1043a-rdb", "fsl,ls1043a";
@@ -139,6 +143,14 @@ LS1043A ARMv8 based QDS Board
 Required root node properties:
     - compatible = "fsl,ls1043a-qds", "fsl,ls1043a";
 
+LS1046A SoC
+Required root node properties:
+    - compatible = "fsl,ls1046a";
+
+LS2080A SoC
+Required root node properties:
+    - compatible = "fsl,ls2080a";
+
 LS2080A ARMv8 based Simulator model
 Required root node properties:
     - compatible = "fsl,ls2080a-simu", "fsl,ls2080a";
-- 
2.1.0.27.g96db324
