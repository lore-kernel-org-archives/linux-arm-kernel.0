From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 29 Feb 2012 09:20:54 +0100
Subject: [PATCH 3/3] devicetree-bindings: Add documentation for i.MX generic
 boards
In-Reply-To: <1330503654-2197-1-git-send-email-s.hauer@pengutronix.de>
References: <1330503654-2197-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1330503654-2197-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 Documentation/devicetree/bindings/arm/fsl.txt |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 54bddda..bfbc771 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -28,3 +28,25 @@ Required root node properties:
 i.MX6 Quad SABRE Lite Board
 Required root node properties:
     - compatible = "fsl,imx6q-sabrelite", "fsl,imx6q";
+
+Generic i.MX boards
+-------------------
+
+No iomux setup is done for these boards, so this must have been configured
+by the bootloader for boards to work with the generic bindings.
+
+i.MX27 generic board
+Required root node properties:
+    - compatible = "fsl,imx27";
+
+i.MX51 generic board
+Required root node properties:
+    - compatible = "fsl,imx51";
+
+i.MX53 generic board
+Required root node properties:
+    - compatible = "fsl,imx53";
+
+i.MX6q generic board
+Required root node properties:
+    - compatible = "fsl,imx6q";
-- 
1.7.9.1
