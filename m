From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Feb 2016 15:29:12 +0100
Subject: [PATCH 18/70] ARM: dts: r8a7779: use GIC_* defines
In-Reply-To: <cover.1454595846.git.horms+renesas@verge.net.au>
References: <cover.1454595846.git.horms+renesas@verge.net.au>
Message-ID: <854b7733fee0ebdb70e34ffa5f57de4cff319a49.1454595846.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use GIC_* defines for GIC interrupt cells in r8a7779 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7779.dtsi | 78 +++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 6afa909865b5..93f3fdf95e31 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -74,7 +74,7 @@
 	gpio0: gpio at ffc40000 {
 		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
 		reg = <0xffc40000 0x2c>;
-		interrupts = <0 141 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 0 32>;
@@ -85,7 +85,7 @@
 	gpio1: gpio at ffc41000 {
 		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
 		reg = <0xffc41000 0x2c>;
-		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 32 32>;
@@ -96,7 +96,7 @@
 	gpio2: gpio at ffc42000 {
 		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
 		reg = <0xffc42000 0x2c>;
-		interrupts = <0 143 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 64 32>;
@@ -107,7 +107,7 @@
 	gpio3: gpio at ffc43000 {
 		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
 		reg = <0xffc43000 0x2c>;
-		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 96 32>;
@@ -118,7 +118,7 @@
 	gpio4: gpio at ffc44000 {
 		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
 		reg = <0xffc44000 0x2c>;
-		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 128 32>;
@@ -129,7 +129,7 @@
 	gpio5: gpio at ffc45000 {
 		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
 		reg = <0xffc45000 0x2c>;
-		interrupts = <0 146 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 160 32>;
@@ -140,7 +140,7 @@
 	gpio6: gpio at ffc46000 {
 		compatible = "renesas,gpio-r8a7779", "renesas,gpio-rcar";
 		reg = <0xffc46000 0x2c>;
-		interrupts = <0 147 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
 		gpio-ranges = <&pfc 0 192 9>;
@@ -159,10 +159,10 @@
 			<0xfe780044 4>,
 			<0xfe780064 4>,
 			<0xfe780000 4>;
-		interrupts = <0 27 IRQ_TYPE_LEVEL_HIGH
-			      0 28 IRQ_TYPE_LEVEL_HIGH
-			      0 29 IRQ_TYPE_LEVEL_HIGH
-			      0 30 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH
+			      GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 		sense-bitfield-width = <2>;
 	};
 
@@ -171,7 +171,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7779";
 		reg = <0xffc70000 0x1000>;
-		interrupts = <0 79 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_I2C0>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -182,7 +182,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7779";
 		reg = <0xffc71000 0x1000>;
-		interrupts = <0 82 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_I2C1>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -193,7 +193,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7779";
 		reg = <0xffc72000 0x1000>;
-		interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_I2C2>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -204,7 +204,7 @@
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7779";
 		reg = <0xffc73000 0x1000>;
-		interrupts = <0 81 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_I2C3>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -213,7 +213,7 @@
 	scif0: serial at ffe40000 {
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe40000 0x100>;
-		interrupts = <0 88 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF0>;
 		clock-names = "sci_ick";
 		power-domains = <&cpg_clocks>;
@@ -223,7 +223,7 @@
 	scif1: serial at ffe41000 {
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe41000 0x100>;
-		interrupts = <0 89 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF1>;
 		clock-names = "sci_ick";
 		power-domains = <&cpg_clocks>;
@@ -233,7 +233,7 @@
 	scif2: serial at ffe42000 {
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe42000 0x100>;
-		interrupts = <0 90 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF2>;
 		clock-names = "sci_ick";
 		power-domains = <&cpg_clocks>;
@@ -243,7 +243,7 @@
 	scif3: serial at ffe43000 {
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe43000 0x100>;
-		interrupts = <0 91 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF3>;
 		clock-names = "sci_ick";
 		power-domains = <&cpg_clocks>;
@@ -253,7 +253,7 @@
 	scif4: serial at ffe44000 {
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe44000 0x100>;
-		interrupts = <0 92 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF4>;
 		clock-names = "sci_ick";
 		power-domains = <&cpg_clocks>;
@@ -263,7 +263,7 @@
 	scif5: serial at ffe45000 {
 		compatible = "renesas,scif-r8a7779", "renesas,scif";
 		reg = <0xffe45000 0x100>;
-		interrupts = <0 93 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF5>;
 		clock-names = "sci_ick";
 		power-domains = <&cpg_clocks>;
@@ -283,9 +283,9 @@
 	tmu0: timer at ffd80000 {
 		compatible = "renesas,tmu-r8a7779", "renesas,tmu";
 		reg = <0xffd80000 0x30>;
-		interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 33 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 34 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_TMU0>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
@@ -298,9 +298,9 @@
 	tmu1: timer at ffd81000 {
 		compatible = "renesas,tmu-r8a7779", "renesas,tmu";
 		reg = <0xffd81000 0x30>;
-		interrupts = <0 36 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 37 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 38 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_TMU1>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
@@ -313,9 +313,9 @@
 	tmu2: timer at ffd82000 {
 		compatible = "renesas,tmu-r8a7779", "renesas,tmu";
 		reg = <0xffd82000 0x30>;
-		interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 41 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 42 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_TMU2>;
 		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
@@ -328,7 +328,7 @@
 	sata: sata at fc600000 {
 		compatible = "renesas,sata-r8a7779", "renesas,rcar-sata";
 		reg = <0xfc600000 0x2000>;
-		interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7779_CLK_SATA>;
 		power-domains = <&cpg_clocks>;
 	};
@@ -336,7 +336,7 @@
 	sdhi0: sd at ffe4c000 {
 		compatible = "renesas,sdhi-r8a7779";
 		reg = <0xffe4c000 0x100>;
-		interrupts = <0 104 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7779_CLK_SDHI0>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -345,7 +345,7 @@
 	sdhi1: sd at ffe4d000 {
 		compatible = "renesas,sdhi-r8a7779";
 		reg = <0xffe4d000 0x100>;
-		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7779_CLK_SDHI1>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -354,7 +354,7 @@
 	sdhi2: sd at ffe4e000 {
 		compatible = "renesas,sdhi-r8a7779";
 		reg = <0xffe4e000 0x100>;
-		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7779_CLK_SDHI2>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -363,7 +363,7 @@
 	sdhi3: sd at ffe4f000 {
 		compatible = "renesas,sdhi-r8a7779";
 		reg = <0xffe4f000 0x100>;
-		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7779_CLK_SDHI3>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
@@ -372,7 +372,7 @@
 	hspi0: spi at fffc7000 {
 		compatible = "renesas,hspi-r8a7779", "renesas,hspi";
 		reg = <0xfffc7000 0x18>;
-		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&mstp0_clks R8A7779_CLK_HSPI>;
@@ -383,7 +383,7 @@
 	hspi1: spi at fffc8000 {
 		compatible = "renesas,hspi-r8a7779", "renesas,hspi";
 		reg = <0xfffc8000 0x18>;
-		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&mstp0_clks R8A7779_CLK_HSPI>;
@@ -394,7 +394,7 @@
 	hspi2: spi at fffc6000 {
 		compatible = "renesas,hspi-r8a7779", "renesas,hspi";
 		reg = <0xfffc6000 0x18>;
-		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 		clocks = <&mstp0_clks R8A7779_CLK_HSPI>;
@@ -405,7 +405,7 @@
 	du: display at fff80000 {
 		compatible = "renesas,du-r8a7779";
 		reg = <0 0xfff80000 0 0x40000>;
-		interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7779_CLK_DU>;
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
-- 
2.7.0.rc3.207.g0ac5344
