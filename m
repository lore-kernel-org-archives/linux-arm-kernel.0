From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:09:29 +0200
Subject: [PATCH 34/58] arm64: dts: renesas: r8a774a1: Add PWM device nodes
In-Reply-To: <cover.1536828567.git.horms+renesas@verge.net.au>
References: <cover.1536828567.git.horms+renesas@verge.net.au>
Message-ID: <9567a8566850936688c08a6392a3324631f9daeb.1536828567.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

This patch adds PWM[0123456] device nodes to the RZ/G2M (a.k.a R8A774A1)
device tree.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Biju Das <biju.das@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 70 +++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
index dde188004283..c9ac545f08f3 100644
--- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
@@ -816,6 +816,76 @@
 			status = "disabled";
 		};
 
+		pwm0: pwm at e6e30000 {
+			compatible = "renesas,pwm-r8a774a1", "renesas,pwm-rcar";
+			reg = <0 0xe6e30000 0 0x8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc 32>;
+			status = "disabled";
+		};
+
+		pwm1: pwm at e6e31000 {
+			compatible = "renesas,pwm-r8a774a1", "renesas,pwm-rcar";
+			reg = <0 0xe6e31000 0 0x8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc 32>;
+			status = "disabled";
+		};
+
+		pwm2: pwm at e6e32000 {
+			compatible = "renesas,pwm-r8a774a1", "renesas,pwm-rcar";
+			reg = <0 0xe6e32000 0 0x8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc 32>;
+			status = "disabled";
+		};
+
+		pwm3: pwm at e6e33000 {
+			compatible = "renesas,pwm-r8a774a1", "renesas,pwm-rcar";
+			reg = <0 0xe6e33000 0 0x8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc 32>;
+			status = "disabled";
+		};
+
+		pwm4: pwm at e6e34000 {
+			compatible = "renesas,pwm-r8a774a1", "renesas,pwm-rcar";
+			reg = <0 0xe6e34000 0 0x8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc 32>;
+			status = "disabled";
+		};
+
+		pwm5: pwm at e6e35000 {
+			compatible = "renesas,pwm-r8a774a1", "renesas,pwm-rcar";
+			reg = <0 0xe6e35000 0 0x8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc 32>;
+			status = "disabled";
+		};
+
+		pwm6: pwm at e6e36000 {
+			compatible = "renesas,pwm-r8a774a1", "renesas,pwm-rcar";
+			reg = <0 0xe6e36000 0 0x8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc 32>;
+			status = "disabled";
+		};
+
 		scif0: serial at e6e60000 {
 			compatible = "renesas,scif-r8a774a1",
 				     "renesas,rcar-gen3-scif", "renesas,scif";
-- 
2.11.0
