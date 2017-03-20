From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:58:07 +0100
Subject: [PATCH 28/31] ARM: dts: porter: Drop superfluous status update for
 frequency override
In-Reply-To: <cover.1489999062.git.horms+renesas@verge.net.au>
References: <cover.1489999062.git.horms+renesas@verge.net.au>
Message-ID: <b546d090c8ecca05c83e71d931f6d9ad72a8d730.1489999063.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The pcie_bus_clk device node is already enabled in r8a7791.dtsi, so
there is no need to update its status again.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-porter.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index d9aa2cd6d625..95da5cb9d37a 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -401,7 +401,6 @@
 
 &pcie_bus_clk {
 	clock-frequency = <100000000>;
-	status = "okay";
 };
 
 &pciec {
-- 
2.7.0.rc3.207.g0ac5344
