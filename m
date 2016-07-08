From: shh.xie@gmail.com (shh.xie at gmail.com)
Date: Fri, 8 Jul 2016 18:15:41 +0800
Subject: [PATCH 2/5] Documentation: DT: Add entry for QorIQ LS1046A-RDB board
In-Reply-To: <1467972944-12293-1-git-send-email-shh.xie@gmail.com>
References: <1467972944-12293-1-git-send-email-shh.xie@gmail.com>
Message-ID: <1467972944-12293-3-git-send-email-shh.xie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shaohui Xie <Shaohui.Xie@nxp.com>

Signed-off-by: Shaohui Xie <Shaohui.Xie@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index dbbc095..cabd575 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -139,6 +139,10 @@ LS1043A ARMv8 based QDS Board
 Required root node properties:
     - compatible = "fsl,ls1043a-qds", "fsl,ls1043a";
 
+LS1046A ARMv8 based RDB Board
+Required root node properties:
+    - compatible = "fsl,ls1046a-rdb", "fsl,ls1046a";
+
 LS2080A ARMv8 based Simulator model
 Required root node properties:
     - compatible = "fsl,ls2080a-simu", "fsl,ls2080a";
-- 
2.1.0.27.g96db324
