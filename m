From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  7 Sep 2012 12:14:50 +0100
Subject: [PATCH 10/19] ARM: ux500: Remove redundant #gpio-cell properties from
 HREF and Snowball DT
In-Reply-To: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1347016499-29354-11-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These properties have no place here as the populated nodes are
not related to GPIO Controllers.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/hrefv60plus.dts |    1 -
 arch/arm/boot/dts/snowball.dts    |    1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/hrefv60plus.dts b/arch/arm/boot/dts/hrefv60plus.dts
index 49bdabd..7f0dddb 100644
--- a/arch/arm/boot/dts/hrefv60plus.dts
+++ b/arch/arm/boot/dts/hrefv60plus.dts
@@ -42,7 +42,6 @@
 			mmc-cap-mmc-highspeed;
 			vmmc-supply = <&ab8500_ldo_aux3_reg>;
 
-			#gpio-cells = <1>;
 			cd-gpios  = <&gpio2 31 0x4>; // 95
 
 			status = "okay";
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
