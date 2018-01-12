From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Fri, 12 Jan 2018 16:22:53 +0200
Subject: [PATCH v2 06/16] ARM: dts: pxa: update pwm-cells
In-Reply-To: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
Message-ID: <1515766983-15151-7-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update pwm-cells to 2 to allow initialization of channel number an period.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 arch/arm/boot/dts/pxa25x.dtsi | 4 ++--
 arch/arm/boot/dts/pxa27x.dtsi | 8 ++++----
 arch/arm/boot/dts/pxa3xx.dtsi | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/pxa25x.dtsi b/arch/arm/boot/dts/pxa25x.dtsi
index 95d59be97213..8c55b3552c42 100644
--- a/arch/arm/boot/dts/pxa25x.dtsi
+++ b/arch/arm/boot/dts/pxa25x.dtsi
@@ -70,14 +70,14 @@
 		pwm0: pwm at 40b00000 {
 			compatible = "marvell,pxa250-pwm";
 			reg = <0x40b00000 0x10>;
-			#pwm-cells = <1>;
+			#pwm-cells = <2>;
 			clocks = <&clks CLK_PWM0>;
 		};
 
 		pwm1: pwm at 40b00010 {
 			compatible = "marvell,pxa250-pwm";
 			reg = <0x40b00010 0x10>;
-			#pwm-cells = <1>;
+			#pwm-cells = <2>;
 			clocks = <&clks CLK_PWM1>;
 		};
 	};
diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 747f750f675d..e3db171cfeb1 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -46,28 +46,28 @@
 		pwm0: pwm at 40b00000 {
 			compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
 			reg = <0x40b00000 0x10>;
-			#pwm-cells = <1>;
+			#pwm-cells = <2>;
 			clocks = <&clks CLK_PWM0>;
 		};
 
 		pwm1: pwm at 40b00010 {
 			compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
 			reg = <0x40b00010 0x10>;
-			#pwm-cells = <1>;
+			#pwm-cells = <2>;
 			clocks = <&clks CLK_PWM1>;
 		};
 
 		pwm2: pwm at 40c00000 {
 			compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
 			reg = <0x40c00000 0x10>;
-			#pwm-cells = <1>;
+			#pwm-cells = <2>;
 			clocks = <&clks CLK_PWM0>;
 		};
 
 		pwm3: pwm at 40c00010 {
 			compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
 			reg = <0x40c00010 0x10>;
-			#pwm-cells = <1>;
+			#pwm-cells = <2>;
 			clocks = <&clks CLK_PWM1>;
 		};
 
diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index 55c75b67351c..1f37295b05a3 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -200,7 +200,7 @@
 		pwm0: pwm at 40b00000 {
 			compatible = "marvell,pxa270-pwm";
 			reg = <0x40b00000 0x10>;
-			#pwm-cells = <1>;
+			#pwm-cells = <2>;
 			clocks = <&clks CLK_PWM0>;
 			status = "disabled";
 		};
@@ -208,7 +208,7 @@
 		pwm1: pwm at 40b00010 {
 			compatible = "marvell,pxa270-pwm";
 			reg = <0x40b00010 0x10>;
-			#pwm-cells = <1>;
+			#pwm-cells = <2>;
 			clocks = <&clks CLK_PWM1>;
 			status = "disabled";
 		};
@@ -216,7 +216,7 @@
 		pwm2: pwm at 40c00000 {
 			compatible = "marvell,pxa270-pwm";
 			reg = <0x40c00000 0x10>;
-			#pwm-cells = <1>;
+			#pwm-cells = <2>;
 			clocks = <&clks CLK_PWM0>;
 			status = "disabled";
 		};
@@ -224,7 +224,7 @@
 		pwm3: pwm at 40c00010 {
 			compatible = "marvell,pxa270-pwm";
 			reg = <0x40c00010 0x10>;
-			#pwm-cells = <1>;
+			#pwm-cells = <2>;
 			clocks = <&clks CLK_PWM1>;
 			status = "disabled";
 		};
-- 
2.7.4
