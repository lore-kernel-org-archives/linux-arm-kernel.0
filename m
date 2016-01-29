From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 29 Jan 2016 10:47:36 +0100
Subject: [PATCH v4 06/11] ARM: dts: r8a7779: Rename the serial port clock to
 fck
In-Reply-To: <1454060861-2375-1-git-send-email-geert+renesas@glider.be>
References: <1454060861-2375-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1454060861-2375-7-git-send-email-geert+renesas@glider.be>
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
 arch/arm/boot/dts/r8a7779.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 1671839f55a6349c..8fddfae13865f536 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -216,7 +216,7 @@
 		reg = <0xffe40000 0x100>;
 		interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -227,7 +227,7 @@
 		reg = <0xffe41000 0x100>;
 		interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -238,7 +238,7 @@
 		reg = <0xffe42000 0x100>;
 		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF2>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -249,7 +249,7 @@
 		reg = <0xffe43000 0x100>;
 		interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF3>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -260,7 +260,7 @@
 		reg = <0xffe44000 0x100>;
 		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF4>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
@@ -271,7 +271,7 @@
 		reg = <0xffe45000 0x100>;
 		interrupts = <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp0_clks R8A7779_CLK_SCIF5>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&cpg_clocks>;
 		status = "disabled";
 	};
-- 
1.9.1
