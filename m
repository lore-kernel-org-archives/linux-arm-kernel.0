From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun,  2 Feb 2014 14:39:47 +0100
Subject: [PATCH 2/2] ARM: sunxi: dt: Convert to the new i2c compatibles
In-Reply-To: <1391348387-9577-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1391348387-9577-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1391348387-9577-2-git-send-email-maxime.ripard@free-electrons.com>
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
index 040bb0e..9508fb7 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -512,7 +512,7 @@
 		};
 
 		i2c0: i2c at 01c2ac00 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <7>;
 			clocks = <&apb1_gates 0>;
@@ -521,7 +521,7 @@
 		};
 
 		i2c1: i2c at 01c2b000 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <8>;
 			clocks = <&apb1_gates 1>;
@@ -530,7 +530,7 @@
 		};
 
 		i2c2: i2c at 01c2b400 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <9>;
 			clocks = <&apb1_gates 2>;
diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
index ea16054..0d1a3bf 100644
--- a/arch/arm/boot/dts/sun5i-a10s.dtsi
+++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
@@ -431,7 +431,7 @@
 		i2c0: i2c at 01c2ac00 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <7>;
 			clocks = <&apb1_gates 0>;
@@ -442,7 +442,7 @@
 		i2c1: i2c at 01c2b000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <8>;
 			clocks = <&apb1_gates 1>;
@@ -453,7 +453,7 @@
 		i2c2: i2c at 01c2b400 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <9>;
 			clocks = <&apb1_gates 2>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 320335a..9e6f031 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -372,7 +372,7 @@
 		};
 
 		i2c0: i2c at 01c2ac00 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <7>;
 			clocks = <&apb1_gates 0>;
@@ -381,7 +381,7 @@
 		};
 
 		i2c1: i2c at 01c2b000 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <8>;
 			clocks = <&apb1_gates 1>;
@@ -390,7 +390,7 @@
 		};
 
 		i2c2: i2c at 01c2b400 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <9>;
 			clocks = <&apb1_gates 2>;
diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 119f066..0a368d2 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -549,7 +549,7 @@
 		};
 
 		i2c0: i2c at 01c2ac00 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2ac00 0x400>;
 			interrupts = <0 7 4>;
 			clocks = <&apb1_gates 0>;
@@ -558,7 +558,7 @@
 		};
 
 		i2c1: i2c at 01c2b000 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b000 0x400>;
 			interrupts = <0 8 4>;
 			clocks = <&apb1_gates 1>;
@@ -567,7 +567,7 @@
 		};
 
 		i2c2: i2c at 01c2b400 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b400 0x400>;
 			interrupts = <0 9 4>;
 			clocks = <&apb1_gates 2>;
@@ -576,7 +576,7 @@
 		};
 
 		i2c3: i2c at 01c2b800 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2b800 0x400>;
 			interrupts = <0 88 4>;
 			clocks = <&apb1_gates 3>;
@@ -585,7 +585,7 @@
 		};
 
 		i2c4: i2c at 01c2bc00 {
-			compatible = "allwinner,sun4i-i2c";
+			compatible = "allwinner,sun4i-a10-i2c";
 			reg = <0x01c2bc00 0x400>;
 			interrupts = <0 89 4>;
 			clocks = <&apb1_gates 15>;
-- 
1.8.4.2
