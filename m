From: fabio.estevam@nxp.com (Fabio Estevam)
Date: Tue, 10 Jul 2018 13:08:42 -0300
Subject: [PATCH v3 1/6] dt-bindings: freescale: Add bindings for the tigerp
 module
Message-ID: <1531238927-19579-1-git-send-email-fabio.estevam@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add bindings for the tigerp module present on i.MX51.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
Changes since v2:
- None

 Documentation/devicetree/bindings/arm/freescale/tigerp.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/tigerp.txt

diff --git a/Documentation/devicetree/bindings/arm/freescale/tigerp.txt b/Documentation/devicetree/bindings/arm/freescale/tigerp.txt
new file mode 100644
index 0000000..19e2aad
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/tigerp.txt
@@ -0,0 +1,12 @@
+* Freescale Tigerp platform module
+
+Required properties:
+- compatible : Should be "fsl,imx51-tigerp"
+- reg : Address and length of the register set for the device
+
+Example:
+
+tigerp: tigerp at 83fa0000 {
+	compatible = "fsl,imx51-tigerp";
+	reg = <0x83fa0000 0x28>;
+};
-- 
2.7.4
