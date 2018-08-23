From: Anson.Huang@nxp.com (Anson Huang)
Date: Thu, 23 Aug 2018 16:41:14 +0800
Subject: [PATCH V2 2/2] dt-bindings: arm: add missing compatible for i.MX
 boards
In-Reply-To: <1535013674-21356-1-git-send-email-Anson.Huang@nxp.com>
References: <1535013674-21356-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1535013674-21356-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds missing compatible for i.MX boards.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 8a1baa2..968f238 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -57,6 +57,46 @@ i.MX6SLL EVK board
 Required root node properties:
     - compatible = "fsl,imx6sll-evk", "fsl,imx6sll";
 
+i.MX6 Quad Plus SABRE Smart Device Board
+Required root node properties:
+    - compatible = "fsl,imx6qp-sabresd", "fsl,imx6qp";
+
+i.MX6 Quad Plus SABRE Automotive Board
+Required root node properties:
+    - compatible = "fsl,imx6qp-sabreauto", "fsl,imx6qp";
+
+i.MX6 DualLite SABRE Smart Device Board
+Required root node properties:
+    - compatible = "fsl,imx6dl-sabresd", "fsl,imx6dl";
+
+i.MX6 DualLite/Solo SABRE Automotive Board
+Required root node properties:
+    - compatible = "fsl,imx6dl-sabreauto", "fsl,imx6dl";
+
+i.MX6 SoloLite EVK Board
+Required root node properties:
+    - compatible = "fsl,imx6sl-evk", "fsl,imx6sl";
+
+i.MX6 UltraLite 14x14 EVK Board
+Required root node properties:
+    - compatible = "fsl,imx6ul-14x14-evk", "fsl,imx6ul";
+
+i.MX6 UltraLiteLite 14x14 EVK Board
+Required root node properties:
+    - compatible = "fsl,imx6ull-14x14-evk", "fsl,imx6ull";
+
+i.MX6 SoloX SDB Board
+Required root node properties:
+    - compatible = "fsl,imx6sx-sdb", "fsl,imx6sx";
+
+i.MX6 SoloX Sabre Auto Board
+Required root node properties:
+    - compatible = "fsl,imx6sx-sabreauto", "fsl,imx6sx";
+
+i.MX7 SabreSD Board
+Required root node properties:
+    - compatible = "fsl,imx7d-sdb", "fsl,imx7d";
+
 Generic i.MX boards
 -------------------
 
-- 
2.7.4
