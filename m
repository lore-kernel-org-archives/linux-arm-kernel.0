From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 26 Aug 2016 15:49:40 +0200
Subject: [PATCH 2/4] ARM: dts: koelsch: remove label property from led nodes
In-Reply-To: <1472219382-22789-1-git-send-email-horms+renesas@verge.net.au>
References: <1472219382-22789-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1472219382-22789-3-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove label property from led nodes. This seems to have little
value and is used inconsistently amongst Renesas SoCs.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index f8a7d090fd01..92a0658854ca 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -158,15 +158,12 @@
 		compatible = "gpio-leds";
 		led6 {
 			gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
-			label = "LED6";
 		};
 		led7 {
 			gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
-			label = "LED7";
 		};
 		led8 {
 			gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
-			label = "LED8";
 		};
 	};
 
-- 
2.7.0.rc3.207.g0ac5344
