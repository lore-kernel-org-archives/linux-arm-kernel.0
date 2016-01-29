From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 29 Jan 2016 10:32:07 +0100
Subject: [PATCH v4 6/7] ARM: dts: r8a7794: Add SCIF fallback compatibility
 strings
In-Reply-To: <1454059928-975-1-git-send-email-geert+renesas@glider.be>
References: <1454059928-975-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1454059928-975-7-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - Change one-line summary prefix to match current arm-soc practices,

v3:
  - New.
---
 arch/arm/boot/dts/r8a7794.dtsi | 54 ++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 21be4bdc40019f31..a49bf303a02d0589 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -282,7 +282,8 @@
 	};
 
 	scifa0: serial at e6c40000 {
-		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7794",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c40000 0 64>;
 		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFA0>;
@@ -294,7 +295,8 @@
 	};
 
 	scifa1: serial at e6c50000 {
-		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7794",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c50000 0 64>;
 		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFA1>;
@@ -306,7 +308,8 @@
 	};
 
 	scifa2: serial at e6c60000 {
-		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7794",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c60000 0 64>;
 		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFA2>;
@@ -318,7 +321,8 @@
 	};
 
 	scifa3: serial at e6c70000 {
-		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7794",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c70000 0 64>;
 		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7794_CLK_SCIFA3>;
@@ -330,7 +334,8 @@
 	};
 
 	scifa4: serial at e6c78000 {
-		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7794",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c78000 0 64>;
 		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7794_CLK_SCIFA4>;
@@ -342,7 +347,8 @@
 	};
 
 	scifa5: serial at e6c80000 {
-		compatible = "renesas,scifa-r8a7794", "renesas,scifa";
+		compatible = "renesas,scifa-r8a7794",
+			     "renesas,rcar-gen2-scifa", "renesas,scifa";
 		reg = <0 0xe6c80000 0 64>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7794_CLK_SCIFA5>;
@@ -354,7 +360,8 @@
 	};
 
 	scifb0: serial at e6c20000 {
-		compatible = "renesas,scifb-r8a7794", "renesas,scifb";
+		compatible = "renesas,scifb-r8a7794",
+			     "renesas,rcar-gen2-scifb", "renesas,scifb";
 		reg = <0 0xe6c20000 0 64>;
 		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFB0>;
@@ -366,7 +373,8 @@
 	};
 
 	scifb1: serial at e6c30000 {
-		compatible = "renesas,scifb-r8a7794", "renesas,scifb";
+		compatible = "renesas,scifb-r8a7794",
+			     "renesas,rcar-gen2-scifb", "renesas,scifb";
 		reg = <0 0xe6c30000 0 64>;
 		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFB1>;
@@ -378,7 +386,8 @@
 	};
 
 	scifb2: serial at e6ce0000 {
-		compatible = "renesas,scifb-r8a7794", "renesas,scifb";
+		compatible = "renesas,scifb-r8a7794",
+			     "renesas,rcar-gen2-scifb", "renesas,scifb";
 		reg = <0 0xe6ce0000 0 64>;
 		interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFB2>;
@@ -390,7 +399,8 @@
 	};
 
 	scif0: serial at e6e60000 {
-		compatible = "renesas,scif-r8a7794", "renesas,scif";
+		compatible = "renesas,scif-r8a7794", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
 		reg = <0 0xe6e60000 0 64>;
 		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF0>;
@@ -402,7 +412,8 @@
 	};
 
 	scif1: serial at e6e68000 {
-		compatible = "renesas,scif-r8a7794", "renesas,scif";
+		compatible = "renesas,scif-r8a7794", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
 		reg = <0 0xe6e68000 0 64>;
 		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF1>;
@@ -414,7 +425,8 @@
 	};
 
 	scif2: serial at e6e58000 {
-		compatible = "renesas,scif-r8a7794", "renesas,scif";
+		compatible = "renesas,scif-r8a7794", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
 		reg = <0 0xe6e58000 0 64>;
 		interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF2>;
@@ -426,7 +438,8 @@
 	};
 
 	scif3: serial at e6ea8000 {
-		compatible = "renesas,scif-r8a7794", "renesas,scif";
+		compatible = "renesas,scif-r8a7794", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
 		reg = <0 0xe6ea8000 0 64>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF3>;
@@ -438,7 +451,8 @@
 	};
 
 	scif4: serial at e6ee0000 {
-		compatible = "renesas,scif-r8a7794", "renesas,scif";
+		compatible = "renesas,scif-r8a7794", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
 		reg = <0 0xe6ee0000 0 64>;
 		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF4>;
@@ -450,7 +464,8 @@
 	};
 
 	scif5: serial at e6ee8000 {
-		compatible = "renesas,scif-r8a7794", "renesas,scif";
+		compatible = "renesas,scif-r8a7794", "renesas,rcar-gen2-scif",
+			     "renesas,scif";
 		reg = <0 0xe6ee8000 0 64>;
 		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF5>;
@@ -462,7 +477,8 @@
 	};
 
 	hscif0: serial at e62c0000 {
-		compatible = "renesas,hscif-r8a7794", "renesas,hscif";
+		compatible = "renesas,hscif-r8a7794",
+			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62c0000 0 96>;
 		interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_HSCIF0>;
@@ -474,7 +490,8 @@
 	};
 
 	hscif1: serial at e62c8000 {
-		compatible = "renesas,hscif-r8a7794", "renesas,hscif";
+		compatible = "renesas,hscif-r8a7794",
+			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62c8000 0 96>;
 		interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_HSCIF1>;
@@ -486,7 +503,8 @@
 	};
 
 	hscif2: serial at e62d0000 {
-		compatible = "renesas,hscif-r8a7794", "renesas,hscif";
+		compatible = "renesas,hscif-r8a7794",
+			     "renesas,rcar-gen2-hscif", "renesas,hscif";
 		reg = <0 0xe62d0000 0 96>;
 		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_HSCIF2>;
-- 
1.9.1
