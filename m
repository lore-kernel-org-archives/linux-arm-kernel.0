From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  7 Apr 2017 11:58:02 -0400
Subject: [PATCH 4/4] arm64: dts: r8a7795: salvator-x: Drop _clk suffix from
 X12 clock node name
In-Reply-To: <cover.1491578743.git.horms+renesas@verge.net.au>
References: <cover.1491578743.git.horms+renesas@verge.net.au>
Message-ID: <6922bd71adab0a7fe8ffbdc3e72a46431fa29656.1491578743.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The current practice is to not add _clk suffixes to clock node names in
DT, as these names are used as the actual clock names.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index f25241921067..639aa085d996 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -56,7 +56,7 @@
 		reg = <0x0 0x48000000 0x0 0x38000000>;
 	};
 
-	x12_clk: x12_clk {
+	x12_clk: x12 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
 		clock-frequency = <24576000>;
-- 
2.7.0.rc3.207.g0ac5344
