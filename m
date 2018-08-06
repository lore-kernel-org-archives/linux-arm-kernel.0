From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon,  6 Aug 2018 18:09:31 +0200
Subject: [PATCH 2/4] ARM: dts: exynos: Add unused PMIC regulators on
 Exynos5422 Odroid boards
In-Reply-To: <20180806160933.6578-1-krzk@kernel.org>
References: <20180806160933.6578-1-krzk@kernel.org>
Message-ID: <20180806160933.6578-2-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define LDO14, LDO20-22, LDO25 and LOD29-38 unused regulators to
describe the hardware.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 105 ++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
index d0218a82c93a..744fd86a38ad 100644
--- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
@@ -235,6 +235,13 @@
 				regulator-max-microvolt = <2800000>;
 			};
 
+			ldo14_reg: LDO14 {
+				/* Unused */
+				regulator-name = "vdd_ldo14";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
 			ldo15_reg: LDO15 {
 				regulator-name = "vdd_ldo15";
 				regulator-min-microvolt = <3300000>;
@@ -268,6 +275,27 @@
 				regulator-max-microvolt = <2800000>;
 			};
 
+			ldo20_reg: LDO20 {
+				/* Unused */
+				regulator-name = "vdd_ldo20";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			ldo21_reg: LDO21 {
+				/* Unused */
+				regulator-name = "vdd_ldo21";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			ldo22_reg: LDO22 {
+				/* Unused */
+				regulator-name = "vdd_ldo22";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <2375000>;
+			};
+
 			ldo23_reg: LDO23 {
 				regulator-name = "vdd_mifs";
 				regulator-min-microvolt = <1100000>;
@@ -282,6 +310,13 @@
 				regulator-always-on;
 			};
 
+			ldo25_reg: LDO25 {
+				/* Unused */
+				regulator-name = "vdd_ldo25";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
 			ldo26_reg: LDO26 {
 				regulator-name = "vdd_ldo26";
 				regulator-min-microvolt = <3000000>;
@@ -296,6 +331,76 @@
 				regulator-always-on;
 			};
 
+			ldo29_reg: LDO29 {
+				/* Unused */
+				regulator-name = "vdd_ldo29";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			ldo30_reg: LDO30 {
+				/* Unused */
+				regulator-name = "vdd_ldo30";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			ldo31_reg: LDO31 {
+				/* Unused */
+				regulator-name = "vdd_ldo31";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			ldo32_reg: LDO32 {
+				/* Unused */
+				regulator-name = "vdd_ldo32";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			ldo33_reg: LDO33 {
+				/* Unused */
+				regulator-name = "vdd_ldo33";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			ldo34_reg: LDO34 {
+				/* Unused */
+				regulator-name = "vdd_ldo34";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			ldo35_reg: LDO35 {
+				/* Unused */
+				regulator-name = "vdd_ldo35";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <2375000>;
+			};
+
+			ldo36_reg: LDO36 {
+				/* Unused */
+				regulator-name = "vdd_ldo36";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			ldo37_reg: LDO37 {
+				/* Unused */
+				regulator-name = "vdd_ldo37";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
+			ldo38_reg: LDO38 {
+				/* Unused */
+				regulator-name = "vdd_ldo38";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <3950000>;
+			};
+
 			buck1_reg: BUCK1 {
 				regulator-name = "vdd_mif";
 				regulator-min-microvolt = <800000>;
-- 
2.14.1
