From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 12 Feb 2016 20:05:39 +0100
Subject: [PATCH 49/68] ARM: dts: r8a7778: Rename the serial port clock to fck
In-Reply-To: <cover.1455303422.git.horms+renesas@verge.net.au>
References: <cover.1455303422.git.horms+renesas@verge.net.au>
Message-ID: <258b3c31897cefca8430b5d1de4ccbab0049efbc.1455303422.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The clock is really the device functional clock, not the interface
clock. Rename it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 8ea1792c5146..50784e2b632d 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -302,7 +302,7 @@
 		reg = <0xffe40000 0x100>;
 		interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -313,7 +313,7 @@
 		reg = <0xffe41000 0x100>;
 		interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -324,7 +324,7 @@
 		reg = <0xffe42000 0x100>;
 		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF2>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -335,7 +335,7 @@
 		reg = <0xffe43000 0x100>;
 		interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF3>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -346,7 +346,7 @@
 		reg = <0xffe44000 0x100>;
 		interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF4>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -357,7 +357,7 @@
 		reg = <0xffe45000 0x100>;
 		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7778_CLK_SCIF5>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
-- 
2.7.0.rc3.207.g0ac5344
