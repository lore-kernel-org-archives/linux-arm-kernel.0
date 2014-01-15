From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Wed, 15 Jan 2014 11:24:46 +0100
Subject: [PATCH] at91: dt: sam9263: fixed compatibility string for the I2C
Message-ID: <1389781486-29670-1-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/boot/dts/at91sam9263.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index c8fa9b9..7d6dd09 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -523,7 +523,7 @@
 			};
 
 			i2c0: i2c at fff88000 {
-				compatible = "atmel,at91sam9263-i2c";
+				compatible = "atmel,at91sam9260-i2c";
 				reg = <0xfff88000 0x100>;
 				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 6>;
 				#address-cells = <1>;
-- 
1.8.5.2
