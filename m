From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 21 May 2013 13:56:42 +0200
Subject: [PATCH] ARM: ux500: fix typo in STUIB device tree
Message-ID: <1369137402-17580-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The Rohm vendor name was twisted in the STUIB device tree
include file. Fix it up.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/stuib.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/stuib.dtsi b/arch/arm/boot/dts/stuib.dtsi
index 7fa10a7..0fdb259 100644
--- a/arch/arm/boot/dts/stuib.dtsi
+++ b/arch/arm/boot/dts/stuib.dtsi
@@ -53,25 +53,25 @@
 
 		i2c at 80110000 {
 			bu21013_tp at 0x5c {
-				compatible = "rhom,bu21013_tp";
+				compatible = "rohm,bu21013_tp";
 				reg = <0x5c>;
 				touch-gpio = <&gpio2 20 0x4>;
 				avdd-supply = <&ab8500_ldo_aux1_reg>;
 
-				rhom,touch-max-x = <384>;
-				rhom,touch-max-y = <704>;
-				rhom,flip-y;
+				rohm,touch-max-x = <384>;
+				rohm,touch-max-y = <704>;
+				rohm,flip-y;
 			};
 
 			bu21013_tp at 0x5d {
-				compatible = "rhom,bu21013_tp";
+				compatible = "rohm,bu21013_tp";
 				reg = <0x5d>;
 				touch-gpio = <&gpio2 20 0x4>;
 				avdd-supply = <&ab8500_ldo_aux1_reg>;
 
-				rhom,touch-max-x = <384>;
-				rhom,touch-max-y = <704>;
-				rhom,flip-y;
+				rohm,touch-max-x = <384>;
+				rohm,touch-max-y = <704>;
+				rohm,flip-y;
 			};
 		};
 	};
-- 
1.7.11.3
