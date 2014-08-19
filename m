From: wills.wang.open@gmail.com (Wills Wang)
Date: Tue, 19 Aug 2014 11:44:31 +0800
Subject: [PATCH v5 1/2] ARM: dts: sun7i: Add uart3/4/5 and i2c3 pinmux
In-Reply-To: <1408419872-11380-1-git-send-email-wills.wang.open@gmail.com>
References: <1408419872-11380-1-git-send-email-wills.wang.open@gmail.com>
Message-ID: <1408419872-11380-2-git-send-email-wills.wang.open@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add generic dts node for uart3/4/5 and i2c3.

Signed-off-by: Wills Wang <wills.wang.open@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 4011628..11620c2 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -618,6 +618,27 @@
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
@@ -653,6 +674,13 @@
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
-- 
1.8.3.2
