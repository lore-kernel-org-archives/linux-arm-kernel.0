From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Mon, 22 Jul 2013 22:19:01 -0300
Subject: [PATCH] ARM: sunxi: make the leds' names conform to the current
 naming convention
Message-ID: <1374542341-3429-1-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting from Documentation/leds/leds-class.txt:

    LED Device Naming
    =================

    Is currently of the form:

    "devicename:colour:function"

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
index 757c4cd..4580b62 100644
--- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
+++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
@@ -76,12 +76,12 @@
 		pinctrl-0 = <&led_pins_cubieboard>;
 
 		blue {
-			label = "cubieboard::blue";
+			label = "cubieboard:blue:usr";
 			gpios = <&pio 7 21 0>; /* LED1 */
 		};
 
 		green {
-			label = "cubieboard::green";
+			label = "cubieboard:green:usr";
 			gpios = <&pio 7 20 0>; /* LED2 */
 			linux,default-trigger = "heartbeat";
 		};
-- 
1.8.3.3
