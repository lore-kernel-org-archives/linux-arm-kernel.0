From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 19 Jul 2013 15:13:38 +0100
Subject: [PATCH 02/13] ARM: ux500: Remove Snowball DTS entry for National
 Semiconductor LP5521 LED chip
In-Reply-To: <1374243229-8585-1-git-send-email-lee.jones@linaro.org>
References: <1374243229-8585-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1374243229-8585-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It doesn't exist on the Snowball development board.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/snowball.dts | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index 16c2b23..a5d6317 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -173,14 +173,6 @@
 		};
 
 		i2c at 80128000 {
-			lp5521 at 33 {
-				// compatible = "lp5521";
-				reg = <0x33>;
-			};
-			lp5521 at 34 {
-				// compatible = "lp5521";
-				reg = <0x34>;
-			};
 			bh1780 at 29 {
 				// compatible = "rohm,bh1780gli";
 				reg = <0x33>;
-- 
1.8.1.2
