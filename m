From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 29 Jan 2016 10:47:40 +0100
Subject: [PATCH v4 10/11] ARM: dts: r8a7794: Rename the serial port clock to
 fck
In-Reply-To: <1454060861-2375-1-git-send-email-geert+renesas@glider.be>
References: <1454060861-2375-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1454060861-2375-11-git-send-email-geert+renesas@glider.be>
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
 arch/arm/boot/dts/r8a7794.dtsi | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index a49bf303a02d0589..b03a77b3d22f13d2 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -287,7 +287,7 @@
 		reg = <0 0xe6c40000 0 64>;
 		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFA0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x21>, <&dmac0 0x22>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -300,7 +300,7 @@
 		reg = <0 0xe6c50000 0 64>;
 		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFA1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x25>, <&dmac0 0x26>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -313,7 +313,7 @@
 		reg = <0 0xe6c60000 0 64>;
 		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFA2>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x27>, <&dmac0 0x28>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -326,7 +326,7 @@
 		reg = <0 0xe6c70000 0 64>;
 		interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7794_CLK_SCIFA3>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x1b>, <&dmac0 0x1c>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -339,7 +339,7 @@
 		reg = <0 0xe6c78000 0 64>;
 		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7794_CLK_SCIFA4>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x1f>, <&dmac0 0x20>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -352,7 +352,7 @@
 		reg = <0 0xe6c80000 0 64>;
 		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp11_clks R8A7794_CLK_SCIFA5>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x23>, <&dmac0 0x24>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -365,7 +365,7 @@
 		reg = <0 0xe6c20000 0 64>;
 		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFB0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x3d>, <&dmac0 0x3e>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -378,7 +378,7 @@
 		reg = <0 0xe6c30000 0 64>;
 		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFB1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x19>, <&dmac0 0x1a>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -391,7 +391,7 @@
 		reg = <0 0xe6ce0000 0 64>;
 		interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7794_CLK_SCIFB2>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x1d>, <&dmac0 0x1e>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -404,7 +404,7 @@
 		reg = <0 0xe6e60000 0 64>;
 		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x29>, <&dmac0 0x2a>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -417,7 +417,7 @@
 		reg = <0 0xe6e68000 0 64>;
 		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x2d>, <&dmac0 0x2e>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -430,7 +430,7 @@
 		reg = <0 0xe6e58000 0 64>;
 		interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF2>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -443,7 +443,7 @@
 		reg = <0 0xe6ea8000 0 64>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF3>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x2f>, <&dmac0 0x30>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -456,7 +456,7 @@
 		reg = <0 0xe6ee0000 0 64>;
 		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF4>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0xfb>, <&dmac0 0xfc>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -469,7 +469,7 @@
 		reg = <0 0xe6ee8000 0 64>;
 		interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_SCIF5>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0xfd>, <&dmac0 0xfe>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -482,7 +482,7 @@
 		reg = <0 0xe62c0000 0 96>;
 		interrupts = <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_HSCIF0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x39>, <&dmac0 0x3a>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -495,7 +495,7 @@
 		reg = <0 0xe62c8000 0 96>;
 		interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_HSCIF1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x4d>, <&dmac0 0x4e>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
@@ -508,7 +508,7 @@
 		reg = <0 0xe62d0000 0 96>;
 		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7794_CLK_HSCIF2>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x3b>, <&dmac0 0x3c>;
 		dma-names = "tx", "rx";
 		power-domains = <&cpg_clocks>;
-- 
1.9.1
