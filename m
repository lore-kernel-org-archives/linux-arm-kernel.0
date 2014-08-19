From: wills.wang.open@gmail.com (Wills Wang)
Date: Tue, 19 Aug 2014 15:33:00 +0800
Subject: [PATH v6 1/2] ARM: dts: sun7i: Add uart3/4/5, i2c3 and spi2 pinmux
In-Reply-To: <1408433581-14417-1-git-send-email-wills.wang.open@gmail.com>
References: <1408433581-14417-1-git-send-email-wills.wang.open@gmail.com>
Message-ID: <1408433581-14417-2-git-send-email-wills.wang.open@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add generic dts node for uart3/4/5, i2c3 and spi2.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Wills Wang <wills.wang.open@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index c658e34..9f16074 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -634,6 +634,27 @@
 				allwinner,pull = <0>;
 			};
 
+			uart3_pins_a: uart3 at 0 {
+				allwinner,pins = "PG6", "PG7", "PG8", "PG9";
+				allwinner,function = "uart3";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			uart4_pins_a: uart4 at 0 {
+				allwinner,pins = "PG10", "PG11";
+				allwinner,function = "uart4";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			uart5_pins_a: uart5 at 0 {
+				allwinner,pins = "PI10", "PI11";
+				allwinner,function = "uart5";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			uart6_pins_a: uart6 at 0 {
 				allwinner,pins = "PI12", "PI13";
 				allwinner,function = "uart6";
@@ -669,6 +690,13 @@
 				allwinner,pull = <0>;
 			};
 
+			i2c3_pins_a: i2c3 at 0 {
+				allwinner,pins = "PI0", "PI1";
+				allwinner,function = "i2c3";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			emac_pins_a: emac0 at 0 {
 				allwinner,pins = "PA0", "PA1", "PA2",
 						"PA3", "PA4", "PA5", "PA6",
@@ -734,6 +762,13 @@
 				allwinner,pull = <0>;
 			};
 
+			spi2_pins_b: spi2 at 1 {
+				allwinner,pins = "PB14", "PB15", "PB16", "PB17";
+				allwinner,function = "spi2";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			mmc0_pins_a: mmc0 at 0 {
 				allwinner,pins = "PF0","PF1","PF2","PF3","PF4","PF5";
 				allwinner,function = "mmc0";
-- 
1.8.3.2
