From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 24 Jan 2018 22:31:16 +0100
Subject: [PATCH] ARM: dts: use 'atmel' as at24 manufacturer for imx6qdl-rex
Message-ID: <20180124213116.4375-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Using 'at' as the <manufacturer> part of the compatible string is now
deprecated. Use a correct string: 'atmel,<model>'.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 arch/arm/boot/dts/imx6qdl-rex.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-rex.dtsi b/arch/arm/boot/dts/imx6qdl-rex.dtsi
index 6e9549ff11da..039e3b8306c4 100644
--- a/arch/arm/boot/dts/imx6qdl-rex.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-rex.dtsi
@@ -137,7 +137,7 @@
 	status = "okay";
 
 	eeprom at 57 {
-		compatible = "at,24c02";
+		compatible = "atmel,24c02";
 		reg = <0x57>;
 	};
 };
-- 
2.16.1
