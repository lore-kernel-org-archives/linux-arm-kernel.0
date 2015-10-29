From: leoli@freescale.com (Li Yang)
Date: Thu, 29 Oct 2015 16:12:04 -0500
Subject: [PATCH V7 1/3] Documentation: DT: Add entry for Freescale LS1043a-RDB
 board
In-Reply-To: <1446153126-6219-1-git-send-email-leoli@freescale.com>
References: <1446153126-6219-1-git-send-email-leoli@freescale.com>
Message-ID: <1446153126-6219-2-git-send-email-leoli@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mingkai Hu <Mingkai.Hu@freescale.com>

Signed-off-by: Mingkai Hu <Mingkai.Hu@freescale.com>
Signed-off-by: Hou Zhiqiang <B48286@freescale.com>
---
v2-v7: no change

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
2.3.3
