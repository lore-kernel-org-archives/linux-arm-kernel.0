From: aisheng.dong@nxp.com (A.s. Dong)
Date: Sat, 10 Nov 2018 15:12:56 +0000
Subject: [PATCH V5 1/6] dt-bindings: fsl: add compatible for imx7ulp evk
In-Reply-To: <1541862478-7839-1-git-send-email-aisheng.dong@nxp.com>
References: <1541862478-7839-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1541862478-7839-2-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: devicetree at vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 7b964d8..9c7c788 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -101,6 +101,10 @@ i.MX7 SabreSD Board
 Required root node properties:
     - compatible = "fsl,imx7d-sdb", "fsl,imx7d";
 
+i.MX7ULP Evaluation Kit
+Required root node properties:
+    - compatible = "fsl,imx7ulp-evk", "fsl,imx7ulp";
+
 Generic i.MX boards
 -------------------
 
@@ -123,6 +127,10 @@ i.MX6q generic board
 Required root node properties:
     - compatible = "fsl,imx6q";
 
+i.MX7ULP generic board
+Required root node properties:
+    - compatible = "fsl,imx7ulp";
+
 Freescale Vybrid Platform Device Tree Bindings
 ----------------------------------------------
 
-- 
2.7.4
