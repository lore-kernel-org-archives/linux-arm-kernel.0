From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 24 Jan 2018 22:28:23 +0100
Subject: [PATCH] ARM: dts: use 'atmel' as at24 manufacturer for
 imx6qdl-zii-rdu2
Message-ID: <20180124212823.4164-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using 'at' as the <manufacturer> part of the compatible string is now
deprecated. Use a correct string: 'atmel,<model>'.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 72f52fcecee1..32b23f24538c 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -498,7 +498,7 @@
 	};
 
 	eeprom at 54 {
-		compatible = "at,24c128";
+		compatible = "atmel,24c128";
 		reg = <0x54>;
 	};
 
-- 
2.16.1
