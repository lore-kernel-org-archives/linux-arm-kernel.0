From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 23 Apr 2014 10:25:44 +0900
Subject: [PATCH 16/33] ARM: shmobile: kzm9g-reference dts: Use KEY_* macros
 for gpio-keys
In-Reply-To: <cover.1398216022.git.horms+renesas@verge.net.au>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
Message-ID: <39f0163098d136411538060fd53c8b8c255cda05.1398216022.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index eb8886b..a99171c 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -14,6 +14,7 @@
 /dts-v1/;
 #include "sh73a0.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 
 / {
@@ -112,43 +113,43 @@
 
 		back-key {
 			gpios = <&pcf8575 8 GPIO_ACTIVE_LOW>;
-			linux,code = <158>;
+			linux,code = <KEY_BACK>;
 			label = "SW3";
 		};
 
 		right-key {
 			gpios = <&pcf8575 9 GPIO_ACTIVE_LOW>;
-			linux,code = <106>;
+			linux,code = <KEY_RIGHT>;
 			label = "SW2-R";
 		};
 
 		left-key {
 			gpios = <&pcf8575 10 GPIO_ACTIVE_LOW>;
-			linux,code = <105>;
+			linux,code = <KEY_LEFT>;
 			label = "SW2-L";
 		};
 
 		enter-key {
 			gpios = <&pcf8575 11 GPIO_ACTIVE_LOW>;
-			linux,code = <28>;
+			linux,code = <KEY_ENTER>;
 			label = "SW2-P";
 		};
 
 		up-key {
 			gpios = <&pcf8575 12 GPIO_ACTIVE_LOW>;
-			linux,code = <103>;
+			linux,code = <KEY_UP>;
 			label = "SW2-U";
 		};
 
 		down-key {
 			gpios = <&pcf8575 13 GPIO_ACTIVE_LOW>;
-			linux,code = <108>;
+			linux,code = <KEY_DOWN>;
 			label = "SW2-D";
 		};
 
 		home-key {
 			gpios = <&pcf8575 14 GPIO_ACTIVE_LOW>;
-			linux,code = <102>;
+			linux,code = <KEY_HOME>;
 			label = "SW1";
 		};
 	};
-- 
1.8.5.2
