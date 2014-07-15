From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 15 Jul 2014 18:16:37 +0900
Subject: [PATCH 7/8] ARM: shmobile: sh73a0: Add SCIF nodes
In-Reply-To: <cover.1405398515.git.horms+renesas@verge.net.au>
References: <cover.1405398515.git.horms+renesas@verge.net.au>
Message-ID: <2131421b85c9f25082a2b0ec371c7ad0c47cc943.1405398515.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This describes all of the SCIF hardware of the sh73a0.
Each node is disabled and may be enabled as necessary
by board DTS files.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 72 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 5ecf552..910b790 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -235,6 +235,78 @@
 		status = "disabled";
 	};
 
+	scifa0: serial at e6c40000 {
+		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
+		reg = <0xe6c40000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 72 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scifa1: serial at e6c50000 {
+		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
+		reg = <0xe6c50000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scifa2: serial at e6c60000 {
+		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
+		reg = <0xe6c60000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scifa3: serial at e6c70000 {
+		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
+		reg = <0xe6c70000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scifa4: serial at e6c80000 {
+		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
+		reg = <0xe6c80000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 78 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scifa5: serial at e6cb0000 {
+		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
+		reg = <0xe6cb0000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 79 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scifa6: serial at e6cc0000 {
+		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
+		reg = <0xe6cc0000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 156 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scifa7: serial at e6cd0000 {
+		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
+		reg = <0xe6cd0000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 143 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scifb8: serial at e6c30000 {
+		compatible = "renesas,scifb-sh73a0", "renesas,scifb";
+		reg = <0xe6c30000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
 	pfc: pfc at e6050000 {
 		compatible = "renesas,pfc-sh73a0";
 		reg = <0xe6050000 0x8000>,
-- 
2.0.0
