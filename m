From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Sep 2012 14:12:48 +0200
Subject: [PATCH 30/32] ARM: ux500: Remove redundant #gpio-cell properties from
 Snowball DT
In-Reply-To: <1348143170-2130-1-git-send-email-lee.jones@linaro.org>
References: <1348143170-2130-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1348143170-2130-31-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This property has no place here as the populated node is not related
to a GPIO controller.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/snowball.dts |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index 2969997..702c0ba 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -127,7 +127,6 @@
 			mmc-cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux3_reg>;
 
-			#gpio-cells = <1>;
 			cd-gpios  = <&gpio6 26 0x4>; // 218
 			cd-inverted;
 
-- 
1.7.9.5
