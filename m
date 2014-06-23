From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:28:10 +0900
Subject: [PATCH 01/29] ARM: shmobile: armadillo800eva reference dts: Add
 matching LED labels
In-Reply-To: <cover.1403487225.git.horms+renesas@verge.net.au>
References: <cover.1403487225.git.horms+renesas@verge.net.au>
Message-ID: <0ba06992e8919128d0547066247de9e54a8bb992.1403487225.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

And make the node name numbering match the label numbering.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: devicetree at vger.kernel.org
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 486007d..f6ef73f 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -104,17 +104,21 @@
 
 	leds {
 		compatible = "gpio-leds";
-		led1 {
+		led3 {
 			gpios = <&pfc 102 GPIO_ACTIVE_HIGH>;
+			label = "LED3";
 		};
-		led2 {
+		led4 {
 			gpios = <&pfc 111 GPIO_ACTIVE_HIGH>;
+			label = "LED4";
 		};
-		led3 {
+		led5 {
 			gpios = <&pfc 110 GPIO_ACTIVE_HIGH>;
+			label = "LED5";
 		};
-		led4 {
+		led6 {
 			gpios = <&pfc 177 GPIO_ACTIVE_HIGH>;
+			label = "LED6";
 		};
 	};
 
-- 
2.0.0.rc2
