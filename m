From: walter@vanguardiasur.com.ar (Walter Lozano)
Date: Thu, 25 Jun 2015 23:25:57 -0300
Subject: [PATCH 1/3] ARM: socfpga: dts: Fix adxl34x formating
Message-ID: <1435285559-11053-1-git-send-email-walter@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the formating of DTS bindings for the adxl34x digital
accelerometer.

Signed-off-by: Walter Lozano <walter@vanguardiasur.com.ar>
---
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
index 71468a7..5b60692 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
@@ -73,14 +73,14 @@
 	status = "okay";
 };
 
-&i2c1{
+&i2c1 {
 	status = "okay";
 
-	accel1: accel1 at 53{
+	accel1: accelerometer at 53 {
 		compatible = "adxl34x";
 		reg = <0x53>;
 
-		interrupt-parent = < &portc >;
+		interrupt-parent = <&portc>;
 		interrupts = <3 2>;
 	};
 };
-- 
1.7.10.4
