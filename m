From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 17 May 2017 23:50:14 +0800
Subject: [PATCH 1/4] dt-bindings: fsl: add compatible for imx7ulp evk
In-Reply-To: <1495036217-20049-1-git-send-email-aisheng.dong@nxp.com>
References: <1495036217-20049-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1495036217-20049-2-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Rob Herring <robh@kernel.org>
Cc: devicetree at vger.kernel.org
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index cdb9dd7..ea10b1f 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -53,6 +53,10 @@ i.MX6 Quad SABRE Automotive Board
 Required root node properties:
     - compatible = "fsl,imx6q-sabreauto", "fsl,imx6q";
 
+i.MX7ULP Evaluation Kit
+Required root node properties:
+    - compatible = "fsl,imx7ulp-evk", "fsl,imx7ulp";
+
 Generic i.MX boards
 -------------------
 
@@ -75,6 +79,10 @@ i.MX6q generic board
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
