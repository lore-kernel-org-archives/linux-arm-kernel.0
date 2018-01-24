From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 24 Jan 2018 22:22:13 +0100
Subject: [PATCH] ARM: dts: use 'atmel' as at24 manufacturer in am335x-boneblue
Message-ID: <20180124212213.3754-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using 'at' as the <manufacturer> part of the compatible string is now
deprecated. Use a correct string: 'atmel,<model>'.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/arm/boot/dts/am335x-boneblue.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-boneblue.dts b/arch/arm/boot/dts/am335x-boneblue.dts
index 3f2480d05a3b..58baee158e64 100644
--- a/arch/arm/boot/dts/am335x-boneblue.dts
+++ b/arch/arm/boot/dts/am335x-boneblue.dts
@@ -342,7 +342,7 @@
 	};
 
 	baseboard_eeprom: baseboard_eeprom at 50 {
-		compatible = "at,24c256";
+		compatible = "atmel,24c256";
 		reg = <0x50>;
 
 		#address-cells = <1>;
-- 
2.16.1
