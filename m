From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 29 Jan 2016 10:47:32 +0100
Subject: [PATCH v4 02/11] ARM: dts: r7s72100: Rename the serial port clock to
 fck
In-Reply-To: <1454060861-2375-1-git-send-email-geert+renesas@glider.be>
References: <1454060861-2375-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1454060861-2375-3-git-send-email-geert+renesas@glider.be>
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
 arch/arm/boot/dts/r7s72100.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index a5938c72d5bde505..89e46ebef1bca7ce 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -158,7 +158,7 @@
 			     <GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -171,7 +171,7 @@
 			     <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 193 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -184,7 +184,7 @@
 			     <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF2>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -197,7 +197,7 @@
 			     <GIC_SPI 204 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF3>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -210,7 +210,7 @@
 			     <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 205 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF4>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -223,7 +223,7 @@
 			     <GIC_SPI 212 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 209 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF5>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -236,7 +236,7 @@
 			     <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 213 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF6>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -249,7 +249,7 @@
 			     <GIC_SPI 220 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp4_clks R7S72100_CLK_SCIF7>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
-- 
1.9.1
