From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:14:39 +0200
Subject: [PATCH 017/102] arm64: dts: renesas: r8a7795: decrease temperature
 hysteresis
In-Reply-To: <cover.1526637994.git.horms+renesas@verge.net.au>
References: <cover.1526637994.git.horms+renesas@verge.net.au>
Message-ID: <02f15e4be78610fbde26aa182ff147f2cc8d2e77.1526637994.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>

To incorporate more tests by the hardware team decrease the hysteresis
value to 1C.

Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 0e958ecd2a41..acf0c6f72a4d 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -2437,12 +2437,12 @@
 			trips {
 				sensor1_passive: sensor1-passive {
 					temperature = <95000>;
-					hysteresis = <2000>;
+					hysteresis = <1000>;
 					type = "passive";
 				};
 				sensor1_crit: sensor1-crit {
 					temperature = <120000>;
-					hysteresis = <2000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -2463,12 +2463,12 @@
 			trips {
 				sensor2_passive: sensor2-passive {
 					temperature = <95000>;
-					hysteresis = <2000>;
+					hysteresis = <1000>;
 					type = "passive";
 				};
 				sensor2_crit: sensor2-crit {
 					temperature = <120000>;
-					hysteresis = <2000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -2489,12 +2489,12 @@
 			trips {
 				sensor3_passive: sensor3-passive {
 					temperature = <95000>;
-					hysteresis = <2000>;
+					hysteresis = <1000>;
 					type = "passive";
 				};
 				sensor3_crit: sensor3-crit {
 					temperature = <120000>;
-					hysteresis = <2000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
-- 
2.11.0
