From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Mon, 9 Oct 2017 19:09:24 +0300
Subject: [PATCH 02/15] ARM: dts: at91: sama5d27_som1_ek: enable i2c2
In-Reply-To: <1507565377-1545-1-git-send-email-claudiu.beznea@microchip.com>
References: <1507565377-1545-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1507565377-1545-3-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable i2c.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
index 43bca17b9e4e..03a4c77fd6ab 100644
--- a/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
+++ b/arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
@@ -133,7 +133,7 @@
 
 			flx1: flexcom at f8038000 {
 				atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
-				status = "disabled";
+				status = "okay";
 
 				i2c2: i2c at 600 {
 					compatible = "atmel,sama5d2-i2c";
@@ -147,7 +147,7 @@
 					pinctrl-names = "default";
 					pinctrl-0 = <&pinctrl_mikrobus_i2c>;
 					atmel,fifo-size = <16>;
-					status = "disabled";
+					status = "okay";
 				};
 			};
 
-- 
2.7.4
