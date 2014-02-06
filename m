From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  6 Feb 2014 10:51:25 +0100
Subject: [PATCH v2 2/2] ARM: sunxi: dt: Convert to the new i2c compatibles
In-Reply-To: <1391680285-16668-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391680285-16668-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1391680285-16668-3-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch the device tree to the new compatibles introduced in the i2c drivers
to have a common pattern accross all Allwinner SoCs.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi  |  6 +++---
 arch/arm/boot/dts/sun5i-a10s.dtsi |  6 +++---
 arch/arm/boot/dts/sun5i-a13.dtsi  |  6 +++---
 arch/arm/boot/dts/sun7i-a20.dtsi  | 10 +++++-----
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 28273f9..ac65c8a 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -518,7 +518,7 @@
 		};
 
 		i2c0: i2c at 01c2ac00 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <7>;
 			clocks = <&apb1_gates 0>;
@@ -527,7 +527,7 @@
 		};
 
 		i2c1: i2c at 01c2b000 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <8>;
 			clocks = <&apb1_gates 1>;
@@ -536,7 +536,7 @@
 		};
 
 		i2c2: i2c at 01c2b400 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <9>;
 			clocks = <&apb1_gates 2>;
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index 2318082..a2005c7 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -435,7 +435,7 @@
 		i2c0: i2c at 01c2ac00 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <7>;
 			clocks = <&apb1_gates 0>;
@@ -446,7 +446,7 @@
 		i2c1: i2c at 01c2b000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <8>;
 			clocks = <&apb1_gates 1>;
@@ -457,7 +457,7 @@
 		i2c2: i2c at 01c2b400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <9>;
 			clocks = <&apb1_gates 2>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 6de40b6..537072c 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -377,7 +377,7 @@
 		};
 
 		i2c0: i2c at 01c2ac00 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <7>;
 			clocks = <&apb1_gates 0>;
@@ -386,7 +386,7 @@
 		};
 
 		i2c1: i2c at 01c2b000 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <8>;
 			clocks = <&apb1_gates 1>;
@@ -395,7 +395,7 @@
 		};
 
 		i2c2: i2c at 01c2b400 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <9>;
 			clocks = <&apb1_gates 2>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index bfb2cf2..ec4463f 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -564,7 +564,7 @@
 		};
 
 		i2c0: i2c at 01c2ac00 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <0 7 4>;
 			clocks = <&apb1_gates 0>;
@@ -573,7 +573,7 @@
 		};
 
 		i2c1: i2c at 01c2b000 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <0 8 4>;
 			clocks = <&apb1_gates 1>;
@@ -582,7 +582,7 @@
 		};
 
 		i2c2: i2c at 01c2b400 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <0 9 4>;
 			clocks = <&apb1_gates 2>;
@@ -591,7 +591,7 @@
 		};
 
 		i2c3: i2c at 01c2b800 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b800 0x400>;
 			interrupts = <0 88 4>;
 			clocks = <&apb1_gates 3>;
@@ -600,7 +600,7 @@
 		};
 
 		i2c4: i2c at 01c2bc00 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2bc00 0x400>;
 			interrupts = <0 89 4>;
 			clocks = <&apb1_gates 15>;
-- 
1.8.4.2
