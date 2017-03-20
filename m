From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:57:40 +0100
Subject: [PATCH 29/32] arm64: dts: h3ulcb: Drop superfluous status update for
 frequency override
In-Reply-To: <cover.1489999913.git.horms+renesas@verge.net.au>
References: <cover.1489999913.git.horms+renesas@verge.net.au>
Message-ID: <c9060f50d82fc9b548571a9adea9ebff22b3347b.1489999913.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The scif_clk device node is already enabled in r8a7795.dtsi, so there is
no need to update its status again.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
index 69c623faf80c..ab352159de65 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
@@ -228,7 +228,6 @@
 
 &scif_clk {
 	clock-frequency = <14745600>;
-	status = "okay";
 };
 
 &i2c2 {
-- 
2.7.0.rc3.207.g0ac5344
