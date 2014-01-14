From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 14 Jan 2014 22:49:50 +0800
Subject: [PATCH] ARM: dts: sun7i: add pin muxing options for UART2
Message-ID: <1389710990-16384-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UART2 is used on CubieTruck to connect to the Bluetooth module.
Add the pin set used in this case.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 82a74ba..1a5cc19 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -402,6 +402,13 @@
 				allwinner,pull = <0>;
 			};
 
+			uart2_pins_a: uart2 at 0 {
+				allwinner,pins = "PI16", "PI17", "PI18", "PI19";
+				allwinner,function = "uart2";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
 			uart6_pins_a: uart6 at 0 {
 				allwinner,pins = "PI12", "PI13";
 				allwinner,function = "uart6";
-- 
1.8.5.2
