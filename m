From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Aug 2016 15:49:42 +0200
Subject: [PATCH 4/4] ARM: dts: kzm9g: remove label property from led nodes
In-Reply-To: <1472219382-22789-1-git-send-email-horms+renesas@verge.net.au>
References: <1472219382-22789-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1472219382-22789-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove label property from led nodes. This seems to have little
value and is used inconsistently amongst Renesas SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index 3d65f1f6d78b..fa4b6737eb6a 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -88,19 +88,15 @@
 		compatible = "gpio-leds";
 		led1 {
 			gpios = <&pfc 20 GPIO_ACTIVE_LOW>;
-			label = "LED1";
 		};
 		led2 {
 			gpios = <&pfc 21 GPIO_ACTIVE_LOW>;
-			label = "LED2";
 		};
 		led3 {
 			gpios = <&pfc 22 GPIO_ACTIVE_LOW>;
-			label = "LED3";
 		};
 		led4 {
 			gpios = <&pfc 23 GPIO_ACTIVE_LOW>;
-			label = "LED4";
 		};
 	};
 
-- 
2.7.0.rc3.207.g0ac5344
