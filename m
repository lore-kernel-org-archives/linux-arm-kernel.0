From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 19 Mar 2014 17:55:57 +0530
Subject: [PATCH 4/4] ARM: dts: Update Exynos DT files with generic compatible
 strings
In-Reply-To: <1395231957-22032-1-git-send-email-sachin.kamat@linaro.org>
References: <1395231957-22032-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1395231957-22032-5-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add generic compatible strings to the respective board DT files.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 arch/arm/boot/dts/exynos4210-origen.dts         |    2 +-
 arch/arm/boot/dts/exynos4210-smdkv310.dts       |    2 +-
 arch/arm/boot/dts/exynos4210-trats.dts          |    2 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts |    2 +-
 arch/arm/boot/dts/exynos4210.dtsi               |    2 +-
 arch/arm/boot/dts/exynos4212.dtsi               |    2 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts        |    2 +-
 arch/arm/boot/dts/exynos4412-origen.dts         |    2 +-
 arch/arm/boot/dts/exynos4412-smdk4412.dts       |    2 +-
 arch/arm/boot/dts/exynos4412-tiny4412.dts       |    2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts         |    2 +-
 arch/arm/boot/dts/exynos4412.dtsi               |    2 +-
 arch/arm/boot/dts/exynos5250-arndale.dts        |    2 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts       |    2 +-
 arch/arm/boot/dts/exynos5250-snow.dts           |    2 +-
 arch/arm/boot/dts/exynos5250.dtsi               |    2 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts   |    2 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts       |    2 +-
 arch/arm/boot/dts/exynos5420.dtsi               |    2 +-
 arch/arm/boot/dts/exynos5440-sd5v1.dts          |    2 +-
 arch/arm/boot/dts/exynos5440-ssdk5440.dts       |    2 +-
 arch/arm/boot/dts/exynos5440.dtsi               |    2 +-
 22 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 2aa13cb3bbed..72fb11f7ea21 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -19,7 +19,7 @@
 
 / {
 	model = "Insignal Origen evaluation board based on Exynos4210";
-	compatible = "insignal,origen", "samsung,exynos4210";
+	compatible = "insignal,origen", "samsung,exynos4210", "samsung,exynos4";
 
 	memory {
 		reg = <0x40000000 0x10000000
diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index 9c01b718d29d..636d16684750 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -19,7 +19,7 @@
 
 / {
 	model = "Samsung smdkv310 evaluation board based on Exynos4210";
-	compatible = "samsung,smdkv310", "samsung,exynos4210";
+	compatible = "samsung,smdkv310", "samsung,exynos4210", "samsung,exynos4";
 
 	memory {
 		reg = <0x40000000 0x80000000>;
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 63cc571ca307..361cb58052bf 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -17,7 +17,7 @@
 
 / {
 	model = "Samsung Trats based on Exynos4210";
-	compatible = "samsung,trats", "samsung,exynos4210";
+	compatible = "samsung,trats", "samsung,exynos4210", "samsung,exynos4";
 
 	memory {
 		reg =  <0x40000000 0x10000000
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index b893a042e3f7..02f9a05790bc 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -17,7 +17,7 @@
 
 / {
 	model = "Samsung Universal C210 based on Exynos4210 rev0";
-	compatible = "samsung,universal_c210", "samsung,exynos4210";
+	compatible = "samsung,universal_c210", "samsung,exynos4210", "samsung,exynos4";
 
 	memory {
 		reg =  <0x40000000 0x10000000
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index b92982b9607e..a3f4bba099e6 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -23,7 +23,7 @@
 #include "exynos4210-pinctrl.dtsi"
 
 / {
-	compatible = "samsung,exynos4210";
+	compatible = "samsung,exynos4210", "samsung,exynos4";
 
 	aliases {
 		pinctrl0 = &pinctrl_0;
diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index ceefc711793c..3c00e6ec9302 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -20,7 +20,7 @@
 #include "exynos4x12.dtsi"
 
 / {
-	compatible = "samsung,exynos4212";
+	compatible = "samsung,exynos4212", "samsung,exynos4";
 
 	combiner: interrupt-controller@10440000 {
 		samsung,combiner-nr = <18>;
diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 12459b01cca3..31db28a4bb33 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -16,7 +16,7 @@
 
 / {
 	model = "Hardkernel ODROID-X board based on Exynos4412";
-	compatible = "hardkernel,odroid-x", "samsung,exynos4412";
+	compatible = "hardkernel,odroid-x", "samsung,exynos4412", "samsung,exynos4";
 
 	memory {
 		reg = <0x40000000 0x40000000>;
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index 388f03579661..e2c0dcab4d81 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -17,7 +17,7 @@
 
 / {
 	model = "Insignal Origen evaluation board based on Exynos4412";
-	compatible = "insignal,origen4412", "samsung,exynos4412";
+	compatible = "insignal,origen4412", "samsung,exynos4412", "samsung,exynos4";
 
 	memory {
 		reg = <0x40000000 0x40000000>;
diff --git a/arch/arm/boot/dts/exynos4412-smdk4412.dts b/arch/arm/boot/dts/exynos4412-smdk4412.dts
index ad316a1ee9e0..ded0b70f7644 100644
--- a/arch/arm/boot/dts/exynos4412-smdk4412.dts
+++ b/arch/arm/boot/dts/exynos4412-smdk4412.dts
@@ -17,7 +17,7 @@
 
 / {
 	model = "Samsung SMDK evaluation board based on Exynos4412";
-	compatible = "samsung,smdk4412", "samsung,exynos4412";
+	compatible = "samsung,smdk4412", "samsung,exynos4412", "samsung,exynos4";
 
 	memory {
 		reg = <0x40000000 0x40000000>;
diff --git a/arch/arm/boot/dts/exynos4412-tiny4412.dts b/arch/arm/boot/dts/exynos4412-tiny4412.dts
index 0a9831256b33..ea6929d9c621 100644
--- a/arch/arm/boot/dts/exynos4412-tiny4412.dts
+++ b/arch/arm/boot/dts/exynos4412-tiny4412.dts
@@ -16,7 +16,7 @@
 
 / {
 	model = "FriendlyARM TINY4412 board based on Exynos4412";
-	compatible = "friendlyarm,tiny4412", "samsung,exynos4412";
+	compatible = "friendlyarm,tiny4412", "samsung,exynos4412", "samsung,exynos4";
 
 	memory {
 		reg = <0x40000000 0x40000000>;
diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
index 322850640f43..c16b3159b813 100644
--- a/arch/arm/boot/dts/exynos4412-trats2.dts
+++ b/arch/arm/boot/dts/exynos4412-trats2.dts
@@ -17,7 +17,7 @@
 
 / {
 	model = "Samsung Trats 2 based on Exynos4412";
-	compatible = "samsung,trats2", "samsung,exynos4412";
+	compatible = "samsung,trats2", "samsung,exynos4412", "samsung,exynos4";
 
 	aliases {
 		i2c8 = &i2c_ak8975;
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index a40b6e20e92f..15d3c0ac2f5f 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -20,7 +20,7 @@
 #include "exynos4x12.dtsi"
 
 / {
-	compatible = "samsung,exynos4412";
+	compatible = "samsung,exynos4412", "samsung,exynos4";
 
 	combiner: interrupt-controller at 10440000 {
 		samsung,combiner-nr = <20>;
diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 97eef405cfbe..090f9830b129 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -15,7 +15,7 @@
 
 / {
 	model = "Insignal Arndale evaluation board based on EXYNOS5250";
-	compatible = "insignal,arndale", "samsung,exynos5250";
+	compatible = "insignal,arndale", "samsung,exynos5250", "samsung,exynos5";
 
 	memory {
 		reg = <0x40000000 0x80000000>;
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 140de8563e94..a794a705d404 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "SAMSUNG SMDK5250 board based on EXYNOS5250";
-	compatible = "samsung,smdk5250", "samsung,exynos5250";
+	compatible = "samsung,smdk5250", "samsung,exynos5250", "samsung,exynos5";
 
 	aliases {
 	};
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index b13bf499f5e2..1ce1088a00fb 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "Google Snow";
-	compatible = "google,snow", "samsung,exynos5250";
+	compatible = "google,snow", "samsung,exynos5250", "samsung,exynos5";
 
 	aliases {
 		i2c104 = &i2c_104;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index abfceadbb1ea..3c547595a66f 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -24,7 +24,7 @@
 #include <dt-bindings/clk/exynos-audss-clk.h>
 
 / {
-	compatible = "samsung,exynos5250";
+	compatible = "samsung,exynos5250", "samsung,exynos5";
 
 	aliases {
 		spi0 = &spi_0;
diff --git a/arch/arm/boot/dts/exynos5420-arndale-octa.dts b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
index f509e8fc290f..159412011f8d 100644
--- a/arch/arm/boot/dts/exynos5420-arndale-octa.dts
+++ b/arch/arm/boot/dts/exynos5420-arndale-octa.dts
@@ -16,7 +16,7 @@
 
 / {
 	model = "Insignal Arndale Octa evaluation board based on EXYNOS5420";
-	compatible = "insignal,arndale-octa", "samsung,exynos5420";
+	compatible = "insignal,arndale-octa", "samsung,exynos5420", "samsung,exynos5";
 
 	memory {
 		reg = <0x20000000 0x80000000>;
diff --git a/arch/arm/boot/dts/exynos5420-smdk5420.dts b/arch/arm/boot/dts/exynos5420-smdk5420.dts
index ae1ee0470fca..69104850eb5e 100644
--- a/arch/arm/boot/dts/exynos5420-smdk5420.dts
+++ b/arch/arm/boot/dts/exynos5420-smdk5420.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "Samsung SMDK5420 board based on EXYNOS5420";
-	compatible = "samsung,smdk5420", "samsung,exynos5420";
+	compatible = "samsung,smdk5420", "samsung,exynos5420", "samsung,exynos5";
 
 	memory {
 		reg = <0x20000000 0x80000000>;
diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index ea401d3b58e3..b9de97c24e64 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -20,7 +20,7 @@
 #include <dt-bindings/clk/exynos-audss-clk.h>
 
 / {
-	compatible = "samsung,exynos5420";
+	compatible = "samsung,exynos5420", "samsung,exynos5";
 
 	aliases {
 		mshc0 = &mmc_0;
diff --git a/arch/arm/boot/dts/exynos5440-sd5v1.dts b/arch/arm/boot/dts/exynos5440-sd5v1.dts
index 777fb1c2c70f..268609a42b2c 100644
--- a/arch/arm/boot/dts/exynos5440-sd5v1.dts
+++ b/arch/arm/boot/dts/exynos5440-sd5v1.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "SAMSUNG SD5v1 board based on EXYNOS5440";
-	compatible = "samsung,sd5v1", "samsung,exynos5440";
+	compatible = "samsung,sd5v1", "samsung,exynos5440", "samsung,exynos5";
 
 	chosen {
 		bootargs = "root=/dev/sda2 rw rootwait ignore_loglevel earlyprintk no_console_suspend mem=2048M at 0x80000000 mem=6144M at 0x100000000 console=ttySAC0,115200";
diff --git a/arch/arm/boot/dts/exynos5440-ssdk5440.dts b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
index d58cb787061a..ff55dac6e219 100644
--- a/arch/arm/boot/dts/exynos5440-ssdk5440.dts
+++ b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
@@ -14,7 +14,7 @@
 
 / {
 	model = "SAMSUNG SSDK5440 board based on EXYNOS5440";
-	compatible = "samsung,ssdk5440", "samsung,exynos5440";
+	compatible = "samsung,ssdk5440", "samsung,exynos5440", "samsung,exynos5";
 
 	chosen {
 		bootargs = "root=/dev/sda2 rw rootwait ignore_loglevel earlyprintk no_console_suspend mem=2048M at 0x80000000 mem=6144M at 0x100000000 console=ttySAC0,115200";
diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index 75c7b89cec2f..84f77c2fe4d4 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -13,7 +13,7 @@
 #include "skeleton.dtsi"
 
 / {
-	compatible = "samsung,exynos5440";
+	compatible = "samsung,exynos5440", "samsung,exynos5";
 
 	interrupt-parent = <&gic>;
 
-- 
1.7.9.5
