From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 29 Jan 2016 10:47:38 +0100
Subject: [PATCH v4 08/11] ARM: dts: r8a7791: Rename the serial port clock to
 fck
In-Reply-To: <1454060861-2375-1-git-send-email-geert+renesas@glider.be>
References: <1454060861-2375-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1454060861-2375-9-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The clock is really the device functional clock, not the interface
clock. Rename it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v4:
  - Change one-line summary prefix to match current arm-soc practices,

v3:
  - No changes,

v2:
  - Add Acked-by.
---
 arch/arm/boot/dts/r8a7791.dtsi | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index e7537ba68b5edae7..194e9464b7487af0 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -569,7 +569,7 @@
 		reg = <0 0xe6c40000 0 64>;
 		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFA0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x21>, <&dmac0 0x22>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -582,7 +582,7 @@
 		reg = <0 0xe6c50000 0 64>;
 		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFA1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x25>, <&dmac0 0x26>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -595,7 +595,7 @@
 		reg = <0 0xe6c60000 0 64>;
 		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFA2>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x27>, <&dmac0 0x28>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -608,7 +608,7 @@
 		reg = <0 0xe6c70000 0 64>;
 		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7791_CLK_SCIFA3>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x1b>, <&dmac0 0x1c>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -621,7 +621,7 @@
 		reg = <0 0xe6c78000 0 64>;
 		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7791_CLK_SCIFA4>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x1f>, <&dmac0 0x20>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -634,7 +634,7 @@
 		reg = <0 0xe6c80000 0 64>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7791_CLK_SCIFA5>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x23>, <&dmac0 0x24>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -647,7 +647,7 @@
 		reg = <0 0xe6c20000 0 64>;
 		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFB0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -660,7 +660,7 @@
 		reg = <0 0xe6c30000 0 64>;
 		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFB1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x19>, <&dmac0 0x1a>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -673,7 +673,7 @@
 		reg = <0 0xe6ce0000 0 64>;
 		interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7791_CLK_SCIFB2>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -686,7 +686,7 @@
 		reg = <0 0xe6e60000 0 64>;
 		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -699,7 +699,7 @@
 		reg = <0 0xe6e68000 0 64>;
 		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -712,7 +712,7 @@
 		reg = <0 0xe6e58000 0 64>;
 		interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF2>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -725,7 +725,7 @@
 		reg = <0 0xe6ea8000 0 64>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF3>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x2f>, <&dmac0 0x30>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -738,7 +738,7 @@
 		reg = <0 0xe6ee0000 0 64>;
 		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF4>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -751,7 +751,7 @@
 		reg = <0 0xe6ee8000 0 64>;
 		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_SCIF5>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -764,7 +764,7 @@
 		reg = <0 0xe62c0000 0 96>;
 		interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSCIF0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -777,7 +777,7 @@
 		reg = <0 0xe62c8000 0 96>;
 		interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSCIF1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -790,7 +790,7 @@
 		reg = <0 0xe62d0000 0 96>;
 		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSCIF2>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
-- 
1.9.1
