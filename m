From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:09:22 +0200
Subject: [PATCH 27/58] arm64: dts: renesas: r8a774a1: Add GPIO device nodes
In-Reply-To: <cover.1536828567.git.horms+renesas@verge.net.au>
References: <cover.1536828567.git.horms+renesas@verge.net.au>
Message-ID: <53ae5809d306bca13b2d444871374515e08c7dff.1536828567.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Add GPIO device nodes to the DT of the r8a774a1 SoC.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 120 ++++++++++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index c956bf7ecde9..4c251c48619b 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -133,6 +133,126 @@
 			status = "disabled";
 		};
 
+		gpio0: gpio at e6050000 {
+			compatible = "renesas,gpio-r8a774a1",
+				     "renesas,rcar-gen3-gpio";
+			reg = <0 0xe6050000 0 0x50>;
+			interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 0 16>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 912>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 912>;
+		};
+
+		gpio1: gpio at e6051000 {
+			compatible = "renesas,gpio-r8a774a1",
+				     "renesas,rcar-gen3-gpio";
+			reg = <0 0xe6051000 0 0x50>;
+			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 32 29>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 911>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 911>;
+		};
+
+		gpio2: gpio at e6052000 {
+			compatible = "renesas,gpio-r8a774a1",
+				     "renesas,rcar-gen3-gpio";
+			reg = <0 0xe6052000 0 0x50>;
+			interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 64 15>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 910>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 910>;
+		};
+
+		gpio3: gpio at e6053000 {
+			compatible = "renesas,gpio-r8a774a1",
+				     "renesas,rcar-gen3-gpio";
+			reg = <0 0xe6053000 0 0x50>;
+			interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 96 16>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 909>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 909>;
+		};
+
+		gpio4: gpio at e6054000 {
+			compatible = "renesas,gpio-r8a774a1",
+				     "renesas,rcar-gen3-gpio";
+			reg = <0 0xe6054000 0 0x50>;
+			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 128 18>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 908>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 908>;
+		};
+
+		gpio5: gpio at e6055000 {
+			compatible = "renesas,gpio-r8a774a1",
+				     "renesas,rcar-gen3-gpio";
+			reg = <0 0xe6055000 0 0x50>;
+			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 160 26>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 907>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 907>;
+		};
+
+		gpio6: gpio at e6055400 {
+			compatible = "renesas,gpio-r8a774a1",
+				     "renesas,rcar-gen3-gpio";
+			reg = <0 0xe6055400 0 0x50>;
+			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 192 32>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 906>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 906>;
+		};
+
+		gpio7: gpio at e6055800 {
+			compatible = "renesas,gpio-r8a774a1",
+				     "renesas,rcar-gen3-gpio";
+			reg = <0 0xe6055800 0 0x50>;
+			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+			#gpio-cells = <2>;
+			gpio-controller;
+			gpio-ranges = <&pfc 0 224 4>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			clocks = <&cpg CPG_MOD 905>;
+			power-domains = <&sysc 32>;
+			resets = <&cpg 905>;
+		};
+
 		pfc: pin-controller at e6060000 {
 			compatible = "renesas,pfc-r8a774a1";
 			reg = <0 0xe6060000 0 0x50c>;
-- 
2.11.0
