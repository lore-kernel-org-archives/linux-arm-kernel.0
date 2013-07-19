From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 19 Jul 2013 15:13:37 +0100
Subject: [PATCH 01/13] ARM: ux500: Remove Toshiba TC35892 I/O Expander's DT
 entry from Snowball's DTS
In-Reply-To: <1374243229-8585-1-git-send-email-lee.jones@linaro.org>
References: <1374243229-8585-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1374243229-8585-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It doesn't exist on this development board.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/snowball.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index 49824be..16c2b23 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -166,12 +166,6 @@
 		};
 
 		i2c at 80004000 {
-			tc3589x at 42 {
-				//compatible = "tc3589x";
-				reg = <0x42>;
-				gpios = <&gpio6 25 0x4>;
-				interrupt-parent = <&gpio6>;
-			};
 			tps61052 at 33 {
 				//compatible = "tps61052";
 				reg = <0x33>;
-- 
1.8.1.2
