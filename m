From: luoyi.ly@gmail.com (luoyi.ly at gmail.com)
Date: Fri,  3 Jun 2016 14:13:36 +0800
Subject: [linux-sunxi] [PATCH] [V2] ARM: dts: sun7i: Add dts file for
 Bananapi M1 Plus board
In-Reply-To: <574FF94B.3020309@web.de>
References: <574FF94B.3020309@web.de>
Message-ID: <20160603061336.16263-1-luoyi.ly@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Luo Yi <luoyi.ly@gmail.com>

Remove the extra empty line and add signed off. 

Signed-off-by: Luo Yi <luoyi.ly@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
index 6fd55d7..f9063ba 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
@@ -47,7 +47,6 @@
 	compatible = "sinovoip,bpi-m1-plus", "allwinner,sun7i-a20";
 };
 
-
 &codec {
 	status = "okay";
 };
@@ -62,11 +61,8 @@
 		interrupts = <7 15 IRQ_TYPE_LEVEL_LOW>; 
 		interrupt-names = "host-wake";
 	};
-
 };
 
 &mmc3_pins_a {
-    /* AP6210 requires pull-up */
 	allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
 };
-
-- 
2.8.3
