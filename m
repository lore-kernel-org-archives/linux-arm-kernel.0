From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 19 Jul 2013 15:13:40 +0100
Subject: [PATCH 04/13] ARM: ux500: Remove Snowball DTS entry for ROHM
 BH1780GLI ambient light sensor
In-Reply-To: <1374243229-8585-1-git-send-email-lee.jones@linaro.org>
References: <1374243229-8585-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1374243229-8585-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It doesn't exist on the Snowball development board.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/snowball.dts | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index d01ec70..dc5c641 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -165,13 +165,6 @@
 			status = "okay";
 		};
 
-		i2c at 80128000 {
-			bh1780 at 29 {
-				// compatible = "rohm,bh1780gli";
-				reg = <0x33>;
-			};
-		};
-
 		cpufreq-cooling {
 			status = "okay";
 		};
-- 
1.8.1.2
