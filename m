From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 24 Jan 2018 22:25:44 +0100
Subject: [PATCH] ARM: dts: use 'atmel' as at24 manufacturer for at91sam9g20ek
Message-ID: <20180124212544.3972-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using compatible strings without the <manufacturer> part for at24 is
now deprecated. Use a correct 'atmel,<model>' value.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index 50561b7b7939..71df3adfc7ca 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -211,7 +211,7 @@
 		status = "okay";
 
 		24c512 at 50 {
-			compatible = "24c512";
+			compatible = "atmel,24c512";
 			reg = <0x50>;
 		};
 
-- 
2.16.1
