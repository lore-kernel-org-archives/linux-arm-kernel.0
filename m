From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  3 Apr 2017 12:08:08 +0200
Subject: [PATCH 2/3] ARM: dts: r8a7791: Drop _clk suffix from external CAN
 clock node name
In-Reply-To: <1491214089-14093-1-git-send-email-geert+renesas@glider.be>
References: <1491214089-14093-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1491214089-14093-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current practice is to not add _clk suffixes to clock node names in
DT, as these names are used as the actual clock names.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index a6478ca3f4ca7554..4d0c2ce59900f811 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1126,7 +1126,7 @@
 		};
 
 		/* External CAN clock */
-		can_clk: can_clk {
+		can_clk: can {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			/* This value must be overridden by the board. */
-- 
2.7.4
