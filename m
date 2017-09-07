From: jbe@pengutronix.de (Juergen Borleis)
Date: Thu,  7 Sep 2017 11:05:23 +0200
Subject: [PATCH 2/9] ARM: dts: TQma53: define GPIO's active level by macro
 instead of anonymous number
In-Reply-To: <20170907090530.1241-1-jbe@pengutronix.de>
References: <20170907090530.1241-1-jbe@pengutronix.de>
Message-ID: <20170907090530.1241-3-jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
---
 arch/arm/boot/dts/imx53-mba53.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index 11c61844d5d85..5a21562a2dc1b 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -48,7 +48,7 @@
 	reg_backlight: backlight {
 		compatible = "regulator-fixed";
 		regulator-name = "lcd-supply";
-		gpio = <&gpio2 5 0>;
+		gpio = <&gpio2 5 GPIO_ACTIVE_HIGH>;
 		startup-delay-us = <5000>;
 	};
 
-- 
2.11.0
