From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:15:39 +0200
Subject: [PATCH 077/102] arm64: dts: renesas: r8a7795: Correct whitespace
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <399ec3ffb161ccfa0a6aba4e3162a1c5ec90af71.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add missing spaces after commas.
Replace 8 consecutive spaces by a TAB.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 9b080a864ea1..91486b4910ce 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -132,7 +132,7 @@
 		};
 
 		a57_1: cpu at 1 {
-			compatible = "arm,cortex-a57","arm,armv8";
+			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x1>;
 			device_type = "cpu";
 			power-domains = <&sysc R8A7795_PD_CA57_CPU1>;
@@ -144,7 +144,7 @@
 		};
 
 		a57_2: cpu at 2 {
-			compatible = "arm,cortex-a57","arm,armv8";
+			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x2>;
 			device_type = "cpu";
 			power-domains = <&sysc R8A7795_PD_CA57_CPU2>;
@@ -156,7 +156,7 @@
 		};
 
 		a57_3: cpu at 3 {
-			compatible = "arm,cortex-a57","arm,armv8";
+			compatible = "arm,cortex-a57", "arm,armv8";
 			reg = <0x3>;
 			device_type = "cpu";
 			power-domains = <&sysc R8A7795_PD_CA57_CPU3>;
@@ -179,7 +179,7 @@
 		};
 
 		a53_1: cpu at 101 {
-			compatible = "arm,cortex-a53","arm,armv8";
+			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x101>;
 			device_type = "cpu";
 			power-domains = <&sysc R8A7795_PD_CA53_CPU1>;
@@ -190,7 +190,7 @@
 		};
 
 		a53_2: cpu at 102 {
-			compatible = "arm,cortex-a53","arm,armv8";
+			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x102>;
 			device_type = "cpu";
 			power-domains = <&sysc R8A7795_PD_CA53_CPU2>;
@@ -201,7 +201,7 @@
 		};
 
 		a53_3: cpu at 103 {
-			compatible = "arm,cortex-a53","arm,armv8";
+			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x103>;
 			device_type = "cpu";
 			power-domains = <&sysc R8A7795_PD_CA53_CPU3>;
@@ -262,7 +262,7 @@
 	pmu_a57 {
 		compatible = "arm,cortex-a57-pmu";
 		interrupts-extended = <&gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
-		                      <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
+				      <&gic GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>,
 				      <&gic GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
 				      <&gic GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-affinity = <&a57_0>,
-- 
2.11.0
