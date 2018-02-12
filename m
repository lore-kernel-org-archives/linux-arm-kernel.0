From: joonas.kylmala@iki.fi (=?UTF-8?q?Joonas=20Kylm=C3=A4l=C3=A4?=)
Date: Mon, 12 Feb 2018 18:29:45 +0200
Subject: [PATCH 1/1] ARM: dts: sun8i: h2-plus: remove unnecessary mmc1_pins
 node
In-Reply-To: <20180212162945.22152-1-joonas.kylmala@iki.fi>
References: <20180212162945.22152-1-joonas.kylmala@iki.fi>
Message-ID: <20180212162945.22152-2-joonas.kylmala@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mmc1_pins node with bias-pull-up attribute is already defined in
the sunxi-h3-h5.dtsi file. Thus, we can remove it from here.

Signed-off-by: Joonas Kylm?l? <joonas.kylmala@iki.fi>
---
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
index f868cf197c8e..0bc031fe4c56 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts
@@ -134,10 +134,6 @@
 	};
 };
 
-&mmc1_pins {
-	bias-pull-up;
-};
-
 &ohci0 {
 	status = "okay";
 };
-- 
2.11.0
