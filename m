From: walter@vanguardiasur.com.ar (Walter Lozano)
Date: Thu, 25 Jun 2015 23:25:59 -0300
Subject: [PATCH 3/3] ARM: socfpga: dts: Fix adxl345 compatible string
In-Reply-To: <1435285559-11053-1-git-send-email-walter@vanguardiasur.com.ar>
References: <1435285559-11053-1-git-send-email-walter@vanguardiasur.com.ar>
Message-ID: <1435285559-11053-3-git-send-email-walter@vanguardiasur.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the compatible string for adxl345 digital accelerometer
after the deprecation of compatible string adxl345x.

Signed-off-by: Walter Lozano <walter@vanguardiasur.com.ar>
---
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
index d343e03..5e17fd1 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_sockit.dts
@@ -68,7 +68,7 @@
 	status = "okay";
 
 	accel1: accelerometer at 53 {
-		compatible = "adxl34x";
+		compatible = "adi,adxl345";
 		reg = <0x53>;
 
 		interrupt-parent = <&portc>;
-- 
1.7.10.4
