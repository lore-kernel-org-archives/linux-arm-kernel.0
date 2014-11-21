From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Nov 2014 09:54:46 +0900
Subject: [PATCH 20/29] ARM: shmobile: koelsch dts: Add labels for the LEDs
In-Reply-To: <cover.1416476366.git.horms+renesas@verge.net.au>
References: <cover.1416476366.git.horms+renesas@verge.net.au>
Message-ID: <352faa5fedbc9f84faa849ce612ab2633c4db0ec.1416476366.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The LEDs on the koelsch board are labeled using upper-case characters.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index f056e64..a10f534 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -149,12 +149,15 @@
 		compatible = "gpio-leds";
 		led6 {
 			gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+			label = "LED6";
 		};
 		led7 {
 			gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
+			label = "LED7";
 		};
 		led8 {
 			gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
+			label = "LED8";
 		};
 	};
 
-- 
2.1.1
