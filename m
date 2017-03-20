From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:57:41 +0100
Subject: [PATCH 30/32] arm64: dts: r8a7795: salvator-x: Drop superfluous
 status updates for frequency overrides
In-Reply-To: <cover.1489999913.git.horms+renesas@verge.net.au>
References: <cover.1489999913.git.horms+renesas@verge.net.au>
Message-ID: <971939d1da07c7b55d35aca31288cce297731c71.1489999913.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The scif_clk and pcie_bus_clk device nodes are already enabled in
r8a7795.dtsi, so there is no need to update their statuses again.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 277ab8484e0c..f25241921067 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -362,7 +362,6 @@
 
 &scif_clk {
 	clock-frequency = <14745600>;
-	status = "okay";
 };
 
 &i2c2 {
@@ -574,7 +573,6 @@
 
 &pcie_bus_clk {
 	clock-frequency = <100000000>;
-	status = "okay";
 };
 
 &pciec0 {
-- 
2.7.0.rc3.207.g0ac5344
