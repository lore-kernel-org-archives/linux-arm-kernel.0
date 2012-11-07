From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Wed, 07 Nov 2012 16:16:59 +0530
Subject: [PATCH 2/3] ARM: EXYNOS5: Add aliases for i2c controller
In-Reply-To: <1352285220-31544-1-git-send-email-a.kesavan@samsung.com>
References: <1352285220-31544-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1352285220-31544-3-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add aliases to determine the i2c controller instance.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 arch/arm/boot/dts/exynos5250.dtsi |   27 ++++++++++++++++++---------
 1 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index cf6a02d..3ae23fd 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -31,6 +31,15 @@
 		gsc1 = &gsc_1;
 		gsc2 = &gsc_2;
 		gsc3 = &gsc_3;
+		i2c0 = &i2c_0;
+		i2c1 = &i2c_1;
+		i2c2 = &i2c_2;
+		i2c3 = &i2c_3;
+		i2c4 = &i2c_4;
+		i2c5 = &i2c_5;
+		i2c6 = &i2c_6;
+		i2c7 = &i2c_7;
+		i2c8 = &i2c_8;
 	};
 
 	gic:interrupt-controller at 10481000 {
@@ -104,7 +113,7 @@
 		interrupts = <0 54 0>;
 	};
 
-	i2c at 12C60000 {
+	i2c_0: i2c at 12C60000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x12C60000 0x100>;
 		interrupts = <0 56 0>;
@@ -112,7 +121,7 @@
 		#size-cells = <0>;
 	};
 
-	i2c at 12C70000 {
+	i2c_1: i2c at 12C70000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x12C70000 0x100>;
 		interrupts = <0 57 0>;
@@ -120,7 +129,7 @@
 		#size-cells = <0>;
 	};
 
-	i2c at 12C80000 {
+	i2c_2: i2c at 12C80000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x12C80000 0x100>;
 		interrupts = <0 58 0>;
@@ -128,7 +137,7 @@
 		#size-cells = <0>;
 	};
 
-	i2c at 12C90000 {
+	i2c_3: i2c at 12C90000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x12C90000 0x100>;
 		interrupts = <0 59 0>;
@@ -136,7 +145,7 @@
 		#size-cells = <0>;
 	};
 
-	i2c at 12CA0000 {
+	i2c_4: i2c at 12CA0000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x12CA0000 0x100>;
 		interrupts = <0 60 0>;
@@ -144,7 +153,7 @@
 		#size-cells = <0>;
 	};
 
-	i2c at 12CB0000 {
+	i2c_5: i2c at 12CB0000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x12CB0000 0x100>;
 		interrupts = <0 61 0>;
@@ -152,7 +161,7 @@
 		#size-cells = <0>;
 	};
 
-	i2c at 12CC0000 {
+	i2c_6: i2c at 12CC0000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x12CC0000 0x100>;
 		interrupts = <0 62 0>;
@@ -160,7 +169,7 @@
 		#size-cells = <0>;
 	};
 
-	i2c at 12CD0000 {
+	i2c_7: i2c at 12CD0000 {
 		compatible = "samsung,s3c2440-i2c";
 		reg = <0x12CD0000 0x100>;
 		interrupts = <0 63 0>;
@@ -168,7 +177,7 @@
 		#size-cells = <0>;
 	};
 
-	i2c at 12CE0000 {
+	i2c_8: i2c at 12CE0000 {
 		compatible = "samsung,s3c2440-hdmiphy-i2c";
 		reg = <0x12CE0000 0x1000>;
 		interrupts = <0 64 0>;
-- 
1.6.6.1
