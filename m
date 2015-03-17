From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 17 Mar 2015 22:02:08 +0200
Subject: [PATCH] ARM: bcm2835: fix i2c0 node name
Message-ID: <665eba5450334476bb2b4220293b6a97271a6dad.1426622528.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/boot/dts/bcm2835.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 3342cb1407bc..fbf58418399e 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -112,7 +112,7 @@
 			status = "disabled";
 		};
 
-		i2c0: i2c at 20205000 {
+		i2c0: i2c at 7e205000 {
 			compatible = "brcm,bcm2835-i2c";
 			reg = <0x7e205000 0x1000>;
 			interrupts = <2 21>;
-- 
2.1.4
