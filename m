From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  8 Nov 2016 17:32:16 +0100
Subject: [PATCH] arm64: dts: marvell: Fix typo in label name on Armada 37xx
Message-ID: <20161108163216.24470-1-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The label names of the peripheral clocks have a typo. Fix it before it is
more widely used.

Reported-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index c4762538ec01..693c36ac2c70 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -105,7 +105,7 @@
 				status = "disabled";
 			};
 
-			nb_perih_clk: nb-periph-clk at 13000{
+			nb_periph_clk: nb-periph-clk at 13000{
 				compatible = "marvell,armada-3700-periph-clock-nb";
 				reg = <0x13000 0x100>;
 				clocks = <&tbg 0>, <&tbg 1>, <&tbg 2>,
@@ -113,7 +113,7 @@
 				#clock-cells = <1>;
 			};
 
-			sb_perih_clk: sb-periph-clk at 18000{
+			sb_periph_clk: sb-periph-clk at 18000{
 				compatible = "marvell,armada-3700-periph-clock-sb";
 				reg = <0x18000 0x100>;
 				clocks = <&tbg 0>, <&tbg 1>, <&tbg 2>,
-- 
2.10.1
