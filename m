From: Anson.Huang@nxp.com (Anson Huang)
Date: Tue, 18 Sep 2018 14:19:08 +0800
Subject: [PATCH 4/4] dt-bindings: arm: add compatible for i.MX6ULZ 14x14 EVK
 board
In-Reply-To: <1537251548-27845-1-git-send-email-Anson.Huang@nxp.com>
References: <1537251548-27845-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1537251548-27845-5-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds compatible for i.MX6ULZ 14x14 EVK board.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 968f238..9a0ffce 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -85,6 +85,10 @@ i.MX6 UltraLiteLite 14x14 EVK Board
 Required root node properties:
     - compatible = "fsl,imx6ull-14x14-evk", "fsl,imx6ull";
 
+i.MX6 ULZ 14x14 EVK Board
+Required root node properties:
+    - compatible = "fsl,imx6ulz-14x14-evk", "fsl,imx6ulz";
+
 i.MX6 SoloX SDB Board
 Required root node properties:
     - compatible = "fsl,imx6sx-sdb", "fsl,imx6sx";
-- 
2.7.4
