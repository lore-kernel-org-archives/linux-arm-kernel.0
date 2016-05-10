From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 10 May 2016 20:29:30 +0200
Subject: [PATCH] ARM: dts: exynos: Replace deprecated hsi2c compatible on
 Exynos5420
Message-ID: <1462904970-31526-1-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 218e1496135e ("i2c: exynos5: add support for HSI2C on
Exynos5260 SoC") the "samsung,exynos5-hsi2c" is deprecated in favor of
SoC version specific: "samsung,exynos5250-hsi2c".

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 4c8523471c65..549ebf23fee0 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -645,7 +645,7 @@
 	};
 
 	hsi2c_4: i2c at 12CA0000 {
-		compatible = "samsung,exynos5-hsi2c";
+		compatible = "samsung,exynos5250-hsi2c";
 		reg = <0x12CA0000 0x1000>;
 		interrupts = <0 60 0>;
 		#address-cells = <1>;
@@ -658,7 +658,7 @@
 	};
 
 	hsi2c_5: i2c at 12CB0000 {
-		compatible = "samsung,exynos5-hsi2c";
+		compatible = "samsung,exynos5250-hsi2c";
 		reg = <0x12CB0000 0x1000>;
 		interrupts = <0 61 0>;
 		#address-cells = <1>;
@@ -671,7 +671,7 @@
 	};
 
 	hsi2c_6: i2c at 12CC0000 {
-		compatible = "samsung,exynos5-hsi2c";
+		compatible = "samsung,exynos5250-hsi2c";
 		reg = <0x12CC0000 0x1000>;
 		interrupts = <0 62 0>;
 		#address-cells = <1>;
@@ -684,7 +684,7 @@
 	};
 
 	hsi2c_7: i2c at 12CD0000 {
-		compatible = "samsung,exynos5-hsi2c";
+		compatible = "samsung,exynos5250-hsi2c";
 		reg = <0x12CD0000 0x1000>;
 		interrupts = <0 63 0>;
 		#address-cells = <1>;
@@ -697,7 +697,7 @@
 	};
 
 	hsi2c_8: i2c at 12E00000 {
-		compatible = "samsung,exynos5-hsi2c";
+		compatible = "samsung,exynos5250-hsi2c";
 		reg = <0x12E00000 0x1000>;
 		interrupts = <0 87 0>;
 		#address-cells = <1>;
@@ -710,7 +710,7 @@
 	};
 
 	hsi2c_9: i2c at 12E10000 {
-		compatible = "samsung,exynos5-hsi2c";
+		compatible = "samsung,exynos5250-hsi2c";
 		reg = <0x12E10000 0x1000>;
 		interrupts = <0 88 0>;
 		#address-cells = <1>;
@@ -723,7 +723,7 @@
 	};
 
 	hsi2c_10: i2c at 12E20000 {
-		compatible = "samsung,exynos5-hsi2c";
+		compatible = "samsung,exynos5250-hsi2c";
 		reg = <0x12E20000 0x1000>;
 		interrupts = <0 203 0>;
 		#address-cells = <1>;
-- 
2.5.0
