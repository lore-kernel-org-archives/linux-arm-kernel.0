From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Mon, 27 Aug 2012 18:01:53 +0530
Subject: [PATCH 1/2] arm/dts: AM33XX: Convert all hex numbers to lower-case
In-Reply-To: <1346070714-6122-1-git-send-email-hvaibhav@ti.com>
References: <1346070714-6122-1-git-send-email-hvaibhav@ti.com>
Message-ID: <1346070714-6122-2-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To make it consistent, convert all hex number presentation
to lower-case from all am33xx specific nodes.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/am335x-bone.dts |    2 +-
 arch/arm/boot/dts/am335x-evm.dts  |    2 +-
 arch/arm/boot/dts/am33xx.dtsi     |   20 ++++++++++----------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index a7906cb..c64f7fa 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -19,7 +19,7 @@
 	};
 
 	ocp {
-		uart1: serial at 44E09000 {
+		uart1: serial at 44e09000 {
 			status = "okay";
 		};
 	};
diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 5dd8a6b..8963f20 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -19,7 +19,7 @@
 	};
 
 	ocp {
-		uart1: serial at 44E09000 {
+		uart1: serial at 44e09000 {
 			status = "okay";
 		};
 	};
diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index dde76f7..be43511 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -71,7 +71,7 @@
 			#interrupt-cells = <1>;
 		};
 
-		gpio2: gpio at 4804C000 {
+		gpio2: gpio at 4804c000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio2";
 			gpio-controller;
@@ -80,7 +80,7 @@
 			#interrupt-cells = <1>;
 		};
 
-		gpio3: gpio at 481AC000 {
+		gpio3: gpio at 481ac000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio3";
 			gpio-controller;
@@ -89,7 +89,7 @@
 			#interrupt-cells = <1>;
 		};
 
-		gpio4: gpio at 481AE000 {
+		gpio4: gpio at 481ae000 {
 			compatible = "ti,omap4-gpio";
 			ti,hwmods = "gpio4";
 			gpio-controller;
@@ -98,7 +98,7 @@
 			#interrupt-cells = <1>;
 		};
 
-		uart1: serial at 44E09000 {
+		uart1: serial at 44e09000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart1";
 			clock-frequency = <48000000>;
@@ -119,28 +119,28 @@
 			status = "disabled";
 		};
 
-		uart4: serial at 481A6000 {
+		uart4: serial at 481a6000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
 			status = "disabled";
 		};
 
-		uart5: serial at 481A8000 {
+		uart5: serial at 481a8000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart5";
 			clock-frequency = <48000000>;
 			status = "disabled";
 		};
 
-		uart6: serial at 481AA000 {
+		uart6: serial at 481aa000 {
 			compatible = "ti,omap3-uart";
 			ti,hwmods = "uart6";
 			clock-frequency = <48000000>;
 			status = "disabled";
 		};
 
-		i2c1: i2c at 44E0B000 {
+		i2c1: i2c at 44e0b000 {
 			compatible = "ti,omap4-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -148,7 +148,7 @@
 			status = "disabled";
 		};
 
-		i2c2: i2c at 4802A000 {
+		i2c2: i2c at 4802a000 {
 			compatible = "ti,omap4-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -156,7 +156,7 @@
 			status = "disabled";
 		};
 
-		i2c3: i2c at 4819C000 {
+		i2c3: i2c at 4819c000 {
 			compatible = "ti,omap4-i2c";
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
1.7.0.4
