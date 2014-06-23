From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:26:34 +0900
Subject: [PATCH 21/24] ARM: shmobile: r8a7779: Add scif nodes to dtsi
In-Reply-To: <cover.1403487423.git.horms+renesas@verge.net.au>
References: <cover.1403487423.git.horms+renesas@verge.net.au>
Message-ID: <fd953b89f44e541bc584a65ba046d1b4cf77840f.1403487423.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 60 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 61d08f4..94e2fc8 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -196,6 +196,66 @@
 		status = "disabled";
 	};
 
+	scif0: serial at ffe40000 {
+		compatible = "renesas,scif-r8a7779", "renesas,scif";
+		reg = <0xffe40000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif1: serial at ffe41000 {
+		compatible = "renesas,scif-r8a7779", "renesas,scif";
+		reg = <0xffe41000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif2: serial at ffe42000 {
+		compatible = "renesas,scif-r8a7779", "renesas,scif";
+		reg = <0xffe42000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif3: serial at ffe43000 {
+		compatible = "renesas,scif-r8a7779", "renesas,scif";
+		reg = <0xffe43000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 91 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif4: serial at ffe44000 {
+		compatible = "renesas,scif-r8a7779", "renesas,scif";
+		reg = <0xffe44000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 92 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
+	scif5: serial at ffe45000 {
+		compatible = "renesas,scif-r8a7779", "renesas,scif";
+		reg = <0xffe45000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 93 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg_clocks R8A7779_CLK_P>;
+		clock-names = "sci_ick";
+		status = "disabled";
+	};
+
 	pfc: pfc at fffc0000 {
 		compatible = "renesas,pfc-r8a7779";
 		reg = <0xfffc0000 0x23c>;
-- 
2.0.0.rc2
