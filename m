From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 23 May 2017 11:51:08 +0200
Subject: [PATCH 1/2] arm64: dts: rockchip: update common rk3399 operating
 points
Message-ID: <20170523095109.7337-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3399 has multiple variants with different frequency ratings.
The operating points currently in the kernel stem from the op1 variant
used in Gru ChromeOS devices and may not be suitable for general rk3399
chips. Therefore bring it back to the official general operating points.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
index dd82e16236a8..c83460db130a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
@@ -56,22 +56,18 @@
 		};
 		opp02 {
 			opp-hz = /bits/ 64 <816000000>;
-			opp-microvolt = <800000>;
+			opp-microvolt = <850000>;
 		};
 		opp03 {
 			opp-hz = /bits/ 64 <1008000000>;
-			opp-microvolt = <875000>;
+			opp-microvolt = <925000>;
 		};
 		opp04 {
 			opp-hz = /bits/ 64 <1200000000>;
-			opp-microvolt = <925000>;
+			opp-microvolt = <1000000>;
 		};
 		opp05 {
 			opp-hz = /bits/ 64 <1416000000>;
-			opp-microvolt = <1050000>;
-		};
-		opp06 {
-			opp-hz = /bits/ 64 <1512000000>;
 			opp-microvolt = <1125000>;
 		};
 	};
@@ -107,15 +103,11 @@
 		};
 		opp06 {
 			opp-hz = /bits/ 64 <1608000000>;
-			opp-microvolt = <1075000>;
+			opp-microvolt = <1100000>;
 		};
 		opp07 {
 			opp-hz = /bits/ 64 <1800000000>;
-			opp-microvolt = <1150000>;
-		};
-		opp08 {
-			opp-hz = /bits/ 64 <2016000000>;
-			opp-microvolt = <1250000>;
+			opp-microvolt = <1200000>;
 		};
 	};
 };
-- 
2.11.0
