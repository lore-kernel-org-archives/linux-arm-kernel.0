From: shh.xie@gmail.com (shh.xie at gmail.com)
Date: Tue, 13 Sep 2016 16:10:02 +0800
Subject: [PATCH 09/10] [v3] Documentation: DT: Add entry for QorIQ LS1046A-QDS
 board
In-Reply-To: <1473754203-22970-1-git-send-email-shh.xie@gmail.com>
References: <1473754203-22970-1-git-send-email-shh.xie@gmail.com>
Message-ID: <1473754203-22970-10-git-send-email-shh.xie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shaohui Xie <Shaohui.Xie@nxp.com>

Signed-off-by: Shaohui Xie <Shaohui.Xie@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
changes from V1 to V3:
1. none.

 Documentation/devicetree/bindings/arm/fsl.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index d6acdb3..d6ee9c6 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -155,6 +155,10 @@ LS1046A SoC
 Required root node properties:
     - compatible = "fsl,ls1046a";
 
+LS1046A ARMv8 based QDS Board
+Required root node properties:
+    - compatible = "fsl,ls1046a-qds", "fsl,ls1046a";
+
 LS1046A ARMv8 based RDB Board
 Required root node properties:
     - compatible = "fsl,ls1046a-rdb", "fsl,ls1046a";
-- 
2.1.0.27.g96db324
