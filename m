From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 10 Sep 2015 17:20:27 +0200
Subject: [PATCH] ARM: at91: at91sam9n12ek: disable i2c1
Message-ID: <1441898427-17633-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bo Shen <voice.shen@atmel.com>

No device connect to i2c1, so remove it to keep it as disabled.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9n12ek.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index 186a1705f8d3..acf3451a332d 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -71,10 +71,6 @@
 				};
 			};
 
-			i2c1: i2c at f8014000 {
-				status = "okay";
-			};
-
 			mmc0: mmc at f0008000 {
 				pinctrl-0 = <
 					&pinctrl_board_mmc0
-- 
2.1.3
