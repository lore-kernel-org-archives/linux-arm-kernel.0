From: shh.xie@gmail.com (shh.xie at gmail.com)
Date: Mon, 5 Sep 2016 18:01:34 +0800
Subject: [PATCH 6/7] [v2] Documentation: DT: Add entry for QorIQ LS1046A-QDS
 board
In-Reply-To: <1473069695-33092-1-git-send-email-shh.xie@gmail.com>
References: <1473069695-33092-1-git-send-email-shh.xie@gmail.com>
Message-ID: <1473069695-33092-7-git-send-email-shh.xie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shaohui Xie <Shaohui.Xie@nxp.com>

Signed-off-by: Shaohui Xie <Shaohui.Xie@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
changes in V2:
no change.

 Documentation/devicetree/bindings/arm/fsl.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 6ec3c0c..4a51ae3 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -145,6 +145,10 @@ LS1043A ARMv8 based QDS Board
 Required root node properties:
     - compatible = "fsl,ls1043a-qds", "fsl,ls1043a";
 
+LS1046A ARMv8 based QDS Board
+Required root node properties:
+    - compatible = "fsl,ls1046a-qds", "fsl,ls1046a";
+
 LS1046A ARMv8 based RDB Board
 Required root node properties:
     - compatible = "fsl,ls1046a-rdb", "fsl,ls1046a";
-- 
2.1.0.27.g96db324
