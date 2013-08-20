From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 20 Aug 2013 15:52:47 +0200
Subject: [PATCH 7/8] ARM: dts: exynos: Fix missing spaces after labels
In-Reply-To: <1377006768-23174-1-git-send-email-t.figa@samsung.com>
References: <1377006768-23174-1-git-send-email-t.figa@samsung.com>
Message-ID: <1377006768-23174-8-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For consistency with other device tree nodes, this patch adds missing
spaces after node labels.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi            | 4 ++--
 arch/arm/boot/dts/exynos4210.dtsi         | 4 ++--
 arch/arm/boot/dts/exynos4212.dtsi         | 2 +-
 arch/arm/boot/dts/exynos4412.dtsi         | 2 +-
 arch/arm/boot/dts/exynos5.dtsi            | 4 ++--
 arch/arm/boot/dts/exynos5250-smdk5250.dts | 6 +++---
 arch/arm/boot/dts/exynos5440.dtsi         | 2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 93c2501..892d5ea 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -79,14 +79,14 @@
 		reg = <0x10023CE0 0x20>;
 	};
 
-	gic:interrupt-controller at 10490000 {
+	gic: interrupt-controller at 10490000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		reg = <0x10490000 0x1000>, <0x10480000 0x100>;
 	};
 
-	combiner:interrupt-controller at 10440000 {
+	combiner: interrupt-controller at 10440000 {
 		compatible = "samsung,exynos4210-combiner";
 		#interrupt-cells = <2>;
 		interrupt-controller;
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index b0fee69..48ecd7a 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -36,11 +36,11 @@
 		reg = <0x10023CA0 0x20>;
 	};
 
-	gic:interrupt-controller at 10490000 {
+	gic: interrupt-controller at 10490000 {
 		cpu-offset = <0x8000>;
 	};
 
-	combiner:interrupt-controller at 10440000 {
+	combiner: interrupt-controller at 10440000 {
 		samsung,combiner-nr = <16>;
 		interrupts = <0 0 0>, <0 1 0>, <0 2 0>, <0 3 0>,
 			     <0 4 0>, <0 5 0>, <0 6 0>, <0 7 0>,
diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index 443b8a2..94a43f9 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -22,7 +22,7 @@
 / {
 	compatible = "samsung,exynos4212";
 
-	gic:interrupt-controller at 10490000 {
+	gic: interrupt-controller at 10490000 {
 		cpu-offset = <0x8000>;
 	};
 
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 6b0184f..5a82f67 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -22,7 +22,7 @@
 / {
 	compatible = "samsung,exynos4412";
 
-	gic:interrupt-controller at 10490000 {
+	gic: interrupt-controller at 10490000 {
 		cpu-offset = <0x4000>;
 	};
 
diff --git a/arch/arm/boot/dts/exynos5.dtsi b/arch/arm/boot/dts/exynos5.dtsi
index 6afa57d..a25c5ac 100644
--- a/arch/arm/boot/dts/exynos5.dtsi
+++ b/arch/arm/boot/dts/exynos5.dtsi
@@ -23,7 +23,7 @@
 		reg = <0x10000000 0x100>;
 	};
 
-	combiner:interrupt-controller at 10440000 {
+	combiner: interrupt-controller at 10440000 {
 		compatible = "samsung,exynos4210-combiner";
 		#interrupt-cells = <2>;
 		interrupt-controller;
@@ -39,7 +39,7 @@
 				<0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>;
 	};
 
-	gic:interrupt-controller at 10481000 {
+	gic: interrupt-controller at 10481000 {
 		compatible = "arm,cortex-a15-gic", "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
 		interrupt-controller;
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 2538b32..56334d8 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -37,7 +37,7 @@
 		};
 	};
 
-	vdd:fixed-regulator at 0 {
+	vdd: fixed-regulator at 0 {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd-supply";
 		regulator-min-microvolt = <1800000>;
@@ -45,7 +45,7 @@
 		regulator-always-on;
 	};
 
-	dbvdd:fixed-regulator at 1 {
+	dbvdd: fixed-regulator at 1 {
 		compatible = "regulator-fixed";
 		regulator-name = "dbvdd-supply";
 		regulator-min-microvolt = <3300000>;
@@ -53,7 +53,7 @@
 		regulator-always-on;
 	};
 
-	spkvdd:fixed-regulator at 2 {
+	spkvdd: fixed-regulator at 2 {
 		compatible = "regulator-fixed";
 		regulator-name = "spkvdd-supply";
 		regulator-min-microvolt = <5000000>;
diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 5d6cf49..799cb77 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -29,7 +29,7 @@
 		#clock-cells = <1>;
 	};
 
-	gic:interrupt-controller at 2E0000 {
+	gic: interrupt-controller at 2E0000 {
 		compatible = "arm,cortex-a15-gic";
 		#interrupt-cells = <3>;
 		interrupt-controller;
-- 
1.8.3.2
