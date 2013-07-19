From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 19 Jul 2013 15:13:39 +0100
Subject: [PATCH 03/13] ARM: ux500: Remove Snowball DTS entry for TPS61052 chip
In-Reply-To: <1374243229-8585-1-git-send-email-lee.jones@linaro.org>
References: <1374243229-8585-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1374243229-8585-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TPS61052 is a; boost converter, LED driver, LED flash driver and
simple GPIO pin chip. It has no use here however, as it is not
found on the Snowball development board.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/snowball.dts | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index a5d6317..d01ec70 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -165,13 +165,6 @@
 			status = "okay";
 		};
 
-		i2c at 80004000 {
-			tps61052 at 33 {
-				//compatible = "tps61052";
-				reg = <0x33>;
-			};
-		};
-
 		i2c at 80128000 {
 			bh1780 at 29 {
 				// compatible = "rohm,bh1780gli";
-- 
1.8.1.2
