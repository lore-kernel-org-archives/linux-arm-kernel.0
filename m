From: stefan@agner.ch (Stefan Agner)
Date: Wed,  3 Dec 2014 01:12:06 +0100
Subject: [PATCH 07/12] Documentation: dt: imx: add MSCM documentation
In-Reply-To: <1417565531-4507-1-git-send-email-stefan@agner.ch>
References: <1417565531-4507-1-git-send-email-stefan@agner.ch>
Message-ID: <1417565531-4507-8-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for Miscellaneous System Control Module found in
Freescale Vybrid SoCs.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 .../devicetree/bindings/arm/freescale/fsl,vf610-mscm.txt   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm.txt

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm.txt
new file mode 100644
index 0000000..31c58cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,vf610-mscm.txt
@@ -0,0 +1,14 @@
+Freescale Vybrid Miscellaneous System Control Module
+
+The MSCM IP contains Access Control and TrustZone Security hardware,
+CPU Configuration registers and Interrupt Router control.
+
+Required properties:
+- compatible : "fsl,vf610-mscm"
+- reg : the register range of the MSCM module
+
+Example:
+	mscm: mscm at 40001000 {                 
+		compatible = "fsl,vf610-mscm";
+		reg = <0x40001000 0x1000>;    
+	};                                    
-- 
2.1.3
