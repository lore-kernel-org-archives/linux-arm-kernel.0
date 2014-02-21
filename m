From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Feb 2014 15:12:49 +0900
Subject: [PATCH 08/13] ARM: shmobile: r8a7790: remove superfluous
 interrupt-parents
In-Reply-To: <cover.1392961872.git.horms+renesas@verge.net.au>
References: <cover.1392961872.git.horms+renesas@verge.net.au>
Message-ID: <951dc909b22afd52f57e1f74e86415941a057d31.1392961872.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

These values are inherited, so don't need to be specified again.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 858fc58..d7bde1e 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -94,7 +94,6 @@
 	gpio0: gpio at e6050000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
 		reg = <0 0xe6050000 0 0x50>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 4 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
@@ -106,7 +105,6 @@
 	gpio1: gpio at e6051000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
 		reg = <0 0xe6051000 0 0x50>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 5 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
@@ -118,7 +116,6 @@
 	gpio2: gpio at e6052000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
 		reg = <0 0xe6052000 0 0x50>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 6 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
@@ -130,7 +127,6 @@
 	gpio3: gpio at e6053000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
 		reg = <0 0xe6053000 0 0x50>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 7 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
@@ -142,7 +138,6 @@
 	gpio4: gpio at e6054000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
 		reg = <0 0xe6054000 0 0x50>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
@@ -154,7 +149,6 @@
 	gpio5: gpio at e6055000 {
 		compatible = "renesas,gpio-r8a7790", "renesas,gpio-rcar";
 		reg = <0 0xe6055000 0 0x50>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
 		#gpio-cells = <2>;
 		gpio-controller;
@@ -166,7 +160,6 @@
 	thermal at e61f0000 {
 		compatible = "renesas,thermal-r8a7790", "renesas,rcar-thermal";
 		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp5_clks R8A7790_CLK_THERMAL>;
 	};
@@ -184,7 +177,6 @@
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		reg = <0 0xe61c0000 0 0x200>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 0 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 1 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 2 IRQ_TYPE_LEVEL_HIGH>,
@@ -196,7 +188,6 @@
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7790";
 		reg = <0 0xe6508000 0 0x40>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 287 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_I2C0>;
 		status = "disabled";
@@ -207,7 +198,6 @@
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7790";
 		reg = <0 0xe6518000 0 0x40>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 288 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_I2C1>;
 		status = "disabled";
@@ -218,7 +208,6 @@
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7790";
 		reg = <0 0xe6530000 0 0x40>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 286 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_I2C2>;
 		status = "disabled";
@@ -229,7 +218,6 @@
 		#size-cells = <0>;
 		compatible = "renesas,i2c-r8a7790";
 		reg = <0 0xe6540000 0 0x40>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 290 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_I2C3>;
 		status = "disabled";
@@ -238,7 +226,6 @@
 	mmcif0: mmcif at ee200000 {
 		compatible = "renesas,mmcif-r8a7790", "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_MMCIF0>;
 		reg-io-width = <4>;
@@ -248,7 +235,6 @@
 	mmcif1: mmc at ee220000 {
 		compatible = "renesas,mmcif-r8a7790", "renesas,sh-mmcif";
 		reg = <0 0xee220000 0 0x80>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 170 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_MMCIF1>;
 		reg-io-width = <4>;
@@ -263,7 +249,6 @@
 	sdhi0: sd at ee100000 {
 		compatible = "renesas,sdhi-r8a7790";
 		reg = <0 0xee100000 0 0x200>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
 		cap-sd-highspeed;
@@ -273,7 +258,6 @@
 	sdhi1: sd at ee120000 {
 		compatible = "renesas,sdhi-r8a7790";
 		reg = <0 0xee120000 0 0x200>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 166 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI1>;
 		cap-sd-highspeed;
@@ -283,7 +267,6 @@
 	sdhi2: sd at ee140000 {
 		compatible = "renesas,sdhi-r8a7790";
 		reg = <0 0xee140000 0 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 167 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI2>;
 		cap-sd-highspeed;
@@ -293,7 +276,6 @@
 	sdhi3: sd at ee160000 {
 		compatible = "renesas,sdhi-r8a7790";
 		reg = <0 0xee160000 0 0x100>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 168 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI3>;
 		cap-sd-highspeed;
@@ -303,7 +285,6 @@
 	scifa0: serial at e6c40000 {
 		compatible = "renesas,scifa-r8a7790", "renesas,scifa";
 		reg = <0 0xe6c40000 0 64>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFA0>;
 		clock-names = "sci_ick";
@@ -312,7 +293,6 @@
 
 	scifa1: serial at e6c50000 {
 		compatible = "renesas,scifa-r8a7790", "renesas,scifa";
-		interrupt-parent = <&gic>;
 		reg = <0 0xe6c50000 0 64>;
 		interrupts = <0 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFA1>;
@@ -322,7 +302,6 @@
 
 	scifa2: serial at e6c60000 {
 		compatible = "renesas,scifa-r8a7790", "renesas,scifa";
-		interrupt-parent = <&gic>;
 		reg = <0 0xe6c60000 0 64>;
 		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFA2>;
@@ -332,7 +311,6 @@
 
 	scifb0: serial at e6c20000 {
 		compatible = "renesas,scifb-r8a7790", "renesas,scifb";
-		interrupt-parent = <&gic>;
 		reg = <0 0xe6c20000 0 64>;
 		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFB0>;
@@ -342,7 +320,6 @@
 
 	scifb1: serial at e6c30000 {
 		compatible = "renesas,scifb-r8a7790", "renesas,scifb";
-		interrupt-parent = <&gic>;
 		reg = <0 0xe6c30000 0 64>;
 		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFB1>;
@@ -352,7 +329,6 @@
 
 	scifb2: serial at e6ce0000 {
 		compatible = "renesas,scifb-r8a7790", "renesas,scifb";
-		interrupt-parent = <&gic>;
 		reg = <0 0xe6ce0000 0 64>;
 		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFB2>;
@@ -362,7 +338,6 @@
 
 	scif0: serial at e6e60000 {
 		compatible = "renesas,scif-r8a7790", "renesas,scif";
-		interrupt-parent = <&gic>;
 		reg = <0 0xe6e60000 0 64>;
 		interrupts = <0 152 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_SCIF0>;
@@ -372,7 +347,6 @@
 
 	scif1: serial at e6e68000 {
 		compatible = "renesas,scif-r8a7790", "renesas,scif";
-		interrupt-parent = <&gic>;
 		reg = <0 0xe6e68000 0 64>;
 		interrupts = <0 153 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_SCIF1>;
@@ -382,7 +356,6 @@
 
 	hscif0: serial at e62c0000 {
 		compatible = "renesas,hscif-r8a7790", "renesas,hscif";
-		interrupt-parent = <&gic>;
 		reg = <0 0xe62c0000 0 96>;
 		interrupts = <0 154 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_HSCIF0>;
@@ -392,7 +365,6 @@
 
 	hscif1: serial at e62c8000 {
 		compatible = "renesas,hscif-r8a7790", "renesas,hscif";
-		interrupt-parent = <&gic>;
 		reg = <0 0xe62c8000 0 96>;
 		interrupts = <0 155 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_HSCIF1>;
@@ -403,7 +375,6 @@
 	sata0: sata at ee300000 {
 		compatible = "renesas,sata-r8a7790";
 		reg = <0 0xee300000 0 0x2000>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 105 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_SATA0>;
 		status = "disabled";
@@ -412,7 +383,6 @@
 	sata1: sata at ee500000 {
 		compatible = "renesas,sata-r8a7790";
 		reg = <0 0xee500000 0 0x2000>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 106 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp8_clks R8A7790_CLK_SATA1>;
 		status = "disabled";
@@ -756,7 +726,6 @@
 	spi: spi at e6b10000 {
 		compatible = "renesas,qspi-r8a7790", "renesas,qspi";
 		reg = <0 0xe6b10000 0 0x2c>;
-		interrupt-parent = <&gic>;
 		interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp9_clks R8A7790_CLK_QSPI_MOD>;
 		num-cs = <1>;
-- 
1.8.5.2
