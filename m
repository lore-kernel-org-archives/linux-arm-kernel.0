From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Aug 2016 15:49:39 +0200
Subject: [PATCH 1/4] ARM: dts: armadillo800eva: remove label property from led
 nodes
In-Reply-To: <1472219382-22789-1-git-send-email-horms+renesas@verge.net.au>
References: <1472219382-22789-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1472219382-22789-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove label property from led nodes. This seems to have little
value and is used inconsistently amongst Renesas SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
index 7885075428bb..12d528dadcb2 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
@@ -111,19 +111,15 @@
 		compatible = "gpio-leds";
 		led3 {
 			gpios = <&pfc 102 GPIO_ACTIVE_HIGH>;
-			label = "LED3";
 		};
 		led4 {
 			gpios = <&pfc 111 GPIO_ACTIVE_HIGH>;
-			label = "LED4";
 		};
 		led5 {
 			gpios = <&pfc 110 GPIO_ACTIVE_HIGH>;
-			label = "LED5";
 		};
 		led6 {
 			gpios = <&pfc 177 GPIO_ACTIVE_HIGH>;
-			label = "LED6";
 		};
 	};
 
-- 
2.7.0.rc3.207.g0ac5344
