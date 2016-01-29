From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 29 Jan 2016 10:47:33 +0100
Subject: [PATCH v4 03/11] ARM: dts: r8a73a4: Rename the serial port clock to
 fck
In-Reply-To: <1454060861-2375-1-git-send-email-geert+renesas@glider.be>
References: <1454060861-2375-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1454060861-2375-4-git-send-email-geert+renesas@glider.be>
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
 arch/arm/boot/dts/r8a73a4.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 64f3efcd7ba5f4e2..138414a7d1703781 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -335,7 +335,7 @@
 		reg = <0 0xe6c20000 0 0x100>;
 		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A73A4_CLK_SCIFB0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
@@ -345,7 +345,7 @@
 		reg = <0 0xe6c30000 0 0x100>;
 		interrupts = <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A73A4_CLK_SCIFB1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
@@ -355,7 +355,7 @@
 		reg = <0 0xe6c40000 0 0x100>;
 		interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A73A4_CLK_SCIFA0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
@@ -365,7 +365,7 @@
 		reg = <0 0xe6c50000 0 0x100>;
 		interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A73A4_CLK_SCIFA1>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
@@ -375,7 +375,7 @@
 		reg = <0 0xe6ce0000 0 0x100>;
 		interrupts = <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A73A4_CLK_SCIFB2>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&pd_a3sp>;
 		status = "disabled";
 	};
@@ -385,7 +385,7 @@
 		reg = <0 0xe6cf0000 0 0x100>;
 		interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A73A4_CLK_SCIFB3>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		power-domains = <&pd_c4>;
 		status = "disabled";
 	};
-- 
1.9.1
