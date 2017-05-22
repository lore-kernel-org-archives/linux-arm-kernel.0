From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 May 2017 15:58:59 +0200
Subject: [PATCH 26/35] arm64: dts: r8a7796: Add PWM device nodes
In-Reply-To: <cover.1495457812.git.horms+renesas@verge.net.au>
References: <cover.1495457812.git.horms+renesas@verge.net.au>
Message-ID: <eaef33106799e3e58984479d85c80ddf94f9159d.1495457812.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>

This patch adds PWM{0,1,2,3,4,5,6} device nodes for R8A7796 SoC.

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[uli: added resets, shortened reg lengths to 8]
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7796.dtsi | 70 ++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index 8651fc93304d..b418a66f4cec 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -395,6 +395,76 @@
 			status = "disabled";
 		};
 
+		pwm0: pwm at e6e30000 {
+			compatible = "renesas,pwm-r8a7796", "renesas,pwm-rcar";
+			reg = <0 0xe6e30000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		pwm1: pwm at e6e31000 {
+			compatible = "renesas,pwm-r8a7796", "renesas,pwm-rcar";
+			reg = <0 0xe6e31000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		pwm2: pwm at e6e32000 {
+			compatible = "renesas,pwm-r8a7796", "renesas,pwm-rcar";
+			reg = <0 0xe6e32000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		pwm3: pwm at e6e33000 {
+			compatible = "renesas,pwm-r8a7796", "renesas,pwm-rcar";
+			reg = <0 0xe6e33000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		pwm4: pwm at e6e34000 {
+			compatible = "renesas,pwm-r8a7796", "renesas,pwm-rcar";
+			reg = <0 0xe6e34000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		pwm5: pwm at e6e35000 {
+			compatible = "renesas,pwm-r8a7796", "renesas,pwm-rcar";
+			reg = <0 0xe6e35000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		pwm6: pwm at e6e36000 {
+			compatible = "renesas,pwm-r8a7796", "renesas,pwm-rcar";
+			reg = <0 0xe6e36000 0 8>;
+			#pwm-cells = <2>;
+			clocks = <&cpg CPG_MOD 523>;
+			resets = <&cpg 523>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
 		i2c0: i2c at e6500000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.1.4
