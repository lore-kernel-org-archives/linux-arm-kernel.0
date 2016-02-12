From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 12 Feb 2016 20:05:31 +0100
Subject: [PATCH 41/68] ARM: dts: r8a7790: Add SCIF fallback compatibility
 strings
In-Reply-To: <cover.1455303422.git.horms+renesas@verge.net.au>
References: <cover.1455303422.git.horms+renesas@verge.net.au>
Message-ID: <a20dc9f2e4e18ecdf1114b43d2320503f6033917.1455303422.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index cc7eccf0ada7..1d94dfd53141 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -585,7 +585,8 @@
 	};
 
 	scifa0: serial at e6c40000 {
-		compatible = "renesas,scifa-r8a7790", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7790",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c40000 0 64>;
 		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFA0>;
@@ -597,7 +598,8 @@
 	};
 
 	scifa1: serial at e6c50000 {
-		compatible = "renesas,scifa-r8a7790", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7790",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c50000 0 64>;
 		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFA1>;
@@ -609,7 +611,8 @@
 	};
 
 	scifa2: serial at e6c60000 {
-		compatible = "renesas,scifa-r8a7790", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7790",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c60000 0 64>;
 		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFA2>;
@@ -621,7 +624,8 @@
 	};
 
 	scifb0: serial at e6c20000 {
-		compatible = "renesas,scifb-r8a7790", "renesas,scifb";
+		compatible = "renesas,scifb-r8a7790",
+			     "renesas,rcar-gen2-scifb", "renesas,scifb";
 		reg = <0 0xe6c20000 0 64>;
 		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFB0>;
@@ -633,7 +637,8 @@
 	};
 
 	scifb1: serial at e6c30000 {
-		compatible = "renesas,scifb-r8a7790", "renesas,scifb";
+		compatible = "renesas,scifb-r8a7790",
+			     "renesas,rcar-gen2-scifb", "renesas,scifb";
 		reg = <0 0xe6c30000 0 64>;
 		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFB1>;
@@ -645,7 +650,8 @@
 	};
 
 	scifb2: serial at e6ce0000 {
-		compatible = "renesas,scifb-r8a7790", "renesas,scifb";
+		compatible = "renesas,scifb-r8a7790",
+			     "renesas,rcar-gen2-scifb", "renesas,scifb";
 		reg = <0 0xe6ce0000 0 64>;
 		interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFB2>;
@@ -657,7 +663,8 @@
 	};
 
 	scif0: serial at e6e60000 {
-		compatible = "renesas,scif-r8a7790", "renesas,scif";
+		compatible = "renesas,scif-r8a7790", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
 		reg = <0 0xe6e60000 0 64>;
 		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_SCIF0>;
@@ -669,7 +676,8 @@
 	};
 
 	scif1: serial at e6e68000 {
-		compatible = "renesas,scif-r8a7790", "renesas,scif";
+		compatible = "renesas,scif-r8a7790", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
 		reg = <0 0xe6e68000 0 64>;
 		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_SCIF1>;
@@ -681,7 +689,8 @@
 	};
 
 	hscif0: serial at e62c0000 {
-		compatible = "renesas,hscif-r8a7790", "renesas,hscif";
+		compatible = "renesas,hscif-r8a7790",
+			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62c0000 0 96>;
 		interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_HSCIF0>;
@@ -693,7 +702,8 @@
 	};
 
 	hscif1: serial at e62c8000 {
-		compatible = "renesas,hscif-r8a7790", "renesas,hscif";
+		compatible = "renesas,hscif-r8a7790",
+			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62c8000 0 96>;
 		interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_HSCIF1>;
-- 
2.7.0.rc3.207.g0ac5344
