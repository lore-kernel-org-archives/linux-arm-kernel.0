From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 17 Aug 2014 11:52:16 +0800
Subject: [PATCH 10/12] ARM: dts: sun8i: Add pin-muxing info for the i2c
 controllers
In-Reply-To: <1408247538-16950-1-git-send-email-wens@csie.org>
References: <1408247538-16950-1-git-send-email-wens@csie.org>
Message-ID: <1408247538-16950-11-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds pin-muxing info for the i2c controller / port combinations
which are known to be used on actual boards.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 62144e2..4658998 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -277,6 +277,27 @@
 				allwinner,drive = <2>;
 				allwinner,pull = <0>;
 			};
+
+			i2c0_pins_a: i2c0 at 0 {
+				allwinner,pins = "PH2", "PH3";
+				allwinner,function = "i2c0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			i2c1_pins_a: i2c1 at 0 {
+				allwinner,pins = "PH4", "PH5";
+				allwinner,function = "i2c1";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			i2c2_pins_a: i2c2 at 0 {
+				allwinner,pins = "PE12", "PE13";
+				allwinner,function = "i2c2";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		ahb1_rst: reset at 01c202c0 {
-- 
2.1.0
