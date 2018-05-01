From: mylene.josserand@bootlin.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Tue,  1 May 2018 14:31:30 +0200
Subject: [PATCH v8 11/12] ARM: dts: sun8i: Add enable-method for SMP support
 for the A83T SoC
In-Reply-To: <20180501123131.7738-1-mylene.josserand@bootlin.com>
References: <20180501123131.7738-1-mylene.josserand@bootlin.com>
Message-ID: <20180501123131.7738-12-mylene.josserand@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the use of enable-method property for SMP support which allows
to handle the SMP support for this specific SoC.

This commit adds enable-method properties to all CPU nodes.

Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 0669b8dc499d..2be23d600957 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -67,6 +67,7 @@
 			device_type = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
 			cci-control-port = <&cci_control0>;
+			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <0>;
 		};
 
@@ -75,6 +76,7 @@
 			device_type = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
 			cci-control-port = <&cci_control0>;
+			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <1>;
 		};
 
@@ -83,6 +85,7 @@
 			device_type = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
 			cci-control-port = <&cci_control0>;
+			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <2>;
 		};
 
@@ -91,6 +94,7 @@
 			device_type = "cpu";
 			operating-points-v2 = <&cpu0_opp_table>;
 			cci-control-port = <&cci_control0>;
+			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <3>;
 		};
 
@@ -101,6 +105,7 @@
 			device_type = "cpu";
 			operating-points-v2 = <&cpu1_opp_table>;
 			cci-control-port = <&cci_control1>;
+			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <0x100>;
 		};
 
@@ -109,6 +114,7 @@
 			device_type = "cpu";
 			operating-points-v2 = <&cpu1_opp_table>;
 			cci-control-port = <&cci_control1>;
+			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <0x101>;
 		};
 
@@ -117,6 +123,7 @@
 			device_type = "cpu";
 			operating-points-v2 = <&cpu1_opp_table>;
 			cci-control-port = <&cci_control1>;
+			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <0x102>;
 		};
 
@@ -125,6 +132,7 @@
 			device_type = "cpu";
 			operating-points-v2 = <&cpu1_opp_table>;
 			cci-control-port = <&cci_control1>;
+			enable-method = "allwinner,sun8i-a83t-smp";
 			reg = <0x103>;
 		};
 	};
-- 
2.11.0
