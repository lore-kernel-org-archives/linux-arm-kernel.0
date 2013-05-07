From: padma.v@samsung.com (Padmavathi Venna)
Date: Tue, 07 May 2013 11:55:29 +0530
Subject: [PATCH] ARM: samsung: use #include for all device trees
Message-ID: <1367907929-5664-1-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace /include/ (dtc) with #include (C pre-processor) for all
Samsung DT files

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
---

This patch is dependent on below patches by Stephen Warren
http://www.spinics.net/lists/linux-kbuild/msg07616.html

 arch/arm/boot/dts/exynos4.dtsi            |    2 +-
 arch/arm/boot/dts/exynos4210-origen.dts   |    2 +-
 arch/arm/boot/dts/exynos4210-smdkv310.dts |    2 +-
 arch/arm/boot/dts/exynos4210-trats.dts    |    2 +-
 arch/arm/boot/dts/exynos4210.dtsi         |    4 ++--
 arch/arm/boot/dts/exynos4212.dtsi         |    2 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts  |    2 +-
 arch/arm/boot/dts/exynos4412-origen.dts   |    2 +-
 arch/arm/boot/dts/exynos4412-smdk4412.dts |    2 +-
 arch/arm/boot/dts/exynos4412.dtsi         |    2 +-
 arch/arm/boot/dts/exynos4x12.dtsi         |    4 ++--
 arch/arm/boot/dts/exynos5250-arndale.dts  |    2 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts |    2 +-
 arch/arm/boot/dts/exynos5250-snow.dts     |    4 ++--
 arch/arm/boot/dts/exynos5250.dtsi         |    4 ++--
 arch/arm/boot/dts/exynos5440-sd5v1.dts    |    2 +-
 arch/arm/boot/dts/exynos5440-ssdk5440.dts |    2 +-
 arch/arm/boot/dts/exynos5440.dtsi         |    2 +-
 18 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index efd441a..e6f4261 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -19,7 +19,7 @@
  * published by the Free Software Foundation.
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	interrupt-parent = <&gic>;
diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
index 8b0a781..8d7a9e5 100644
--- a/arch/arm/boot/dts/exynos4210-origen.dts
+++ b/arch/arm/boot/dts/exynos4210-origen.dts
@@ -15,7 +15,7 @@
 */
 
 /dts-v1/;
-/include/ "exynos4210.dtsi"
+#include "exynos4210.dtsi"
 
 / {
 	model = "Insignal Origen evaluation board based on Exynos4210";
diff --git a/arch/arm/boot/dts/exynos4210-smdkv310.dts b/arch/arm/boot/dts/exynos4210-smdkv310.dts
index 91332b7..9c01b71 100644
--- a/arch/arm/boot/dts/exynos4210-smdkv310.dts
+++ b/arch/arm/boot/dts/exynos4210-smdkv310.dts
@@ -15,7 +15,7 @@
 */
 
 /dts-v1/;
-/include/ "exynos4210.dtsi"
+#include "exynos4210.dtsi"
 
 / {
 	model = "Samsung smdkv310 evaluation board based on Exynos4210";
diff --git a/arch/arm/boot/dts/exynos4210-trats.dts b/arch/arm/boot/dts/exynos4210-trats.dts
index 9a14484..94eebff 100644
--- a/arch/arm/boot/dts/exynos4210-trats.dts
+++ b/arch/arm/boot/dts/exynos4210-trats.dts
@@ -13,7 +13,7 @@
 */
 
 /dts-v1/;
-/include/ "exynos4210.dtsi"
+#include "exynos4210.dtsi"
 
 / {
 	model = "Samsung Trats based on Exynos4210";
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 5d925ed..e9f878e 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -19,8 +19,8 @@
  * published by the Free Software Foundation.
 */
 
-/include/ "exynos4.dtsi"
-/include/ "exynos4210-pinctrl.dtsi"
+#include "exynos4.dtsi"
+#include "exynos4210-pinctrl.dtsi"
 
 / {
 	compatible = "samsung,exynos4210";
diff --git a/arch/arm/boot/dts/exynos4212.dtsi b/arch/arm/boot/dts/exynos4212.dtsi
index 36d4299..c7a9193 100644
--- a/arch/arm/boot/dts/exynos4212.dtsi
+++ b/arch/arm/boot/dts/exynos4212.dtsi
@@ -17,7 +17,7 @@
  * published by the Free Software Foundation.
 */
 
-/include/ "exynos4x12.dtsi"
+#include "exynos4x12.dtsi"
 
 / {
 	compatible = "samsung,exynos4212";
diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
index 15dc0a3..9f7f467 100644
--- a/arch/arm/boot/dts/exynos4412-odroidx.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
@@ -12,7 +12,7 @@
 */
 
 /dts-v1/;
-/include/ "exynos4412.dtsi"
+#include "exynos4412.dtsi"
 
 / {
 	model = "Hardkernel ODROID-X board based on Exynos4412";
diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
index 65e9c57..cfc6208 100644
--- a/arch/arm/boot/dts/exynos4412-origen.dts
+++ b/arch/arm/boot/dts/exynos4412-origen.dts
@@ -13,7 +13,7 @@
 */
 
 /dts-v1/;
-/include/ "exynos4412.dtsi"
+#include "exynos4412.dtsi"
 
 / {
 	model = "Insignal Origen evaluation board based on Exynos4412";
diff --git a/arch/arm/boot/dts/exynos4412-smdk4412.dts b/arch/arm/boot/dts/exynos4412-smdk4412.dts
index c52b01f..1e816fa 100644
--- a/arch/arm/boot/dts/exynos4412-smdk4412.dts
+++ b/arch/arm/boot/dts/exynos4412-smdk4412.dts
@@ -13,7 +13,7 @@
 */
 
 /dts-v1/;
-/include/ "exynos4412.dtsi"
+#include "exynos4412.dtsi"
 
 / {
 	model = "Samsung SMDK evaluation board based on Exynos4412";
diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 7f42827..fae4f81 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -17,7 +17,7 @@
  * published by the Free Software Foundation.
 */
 
-/include/ "exynos4x12.dtsi"
+#include "exynos4x12.dtsi"
 
 / {
 	compatible = "samsung,exynos4412";
diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
index e3380a7..8896bb5 100644
--- a/arch/arm/boot/dts/exynos4x12.dtsi
+++ b/arch/arm/boot/dts/exynos4x12.dtsi
@@ -17,8 +17,8 @@
  * published by the Free Software Foundation.
 */
 
-/include/ "exynos4.dtsi"
-/include/ "exynos4x12-pinctrl.dtsi"
+#include "exynos4.dtsi"
+#include "exynos4x12-pinctrl.dtsi"
 
 / {
 	aliases {
diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 02cfc76..8e27120 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -10,7 +10,7 @@
 */
 
 /dts-v1/;
-/include/ "exynos5250.dtsi"
+#include "exynos5250.dtsi"
 
 / {
 	model = "Insignal Arndale evaluation board based on EXYNOS5250";
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 26d856b..cea2790 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -10,7 +10,7 @@
 */
 
 /dts-v1/;
-/include/ "exynos5250.dtsi"
+#include "exynos5250.dtsi"
 
 / {
 	model = "SAMSUNG SMDK5250 board based on EXYNOS5250";
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 581ffae..be56289 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -9,8 +9,8 @@
 */
 
 /dts-v1/;
-/include/ "exynos5250.dtsi"
-/include/ "cros5250-common.dtsi"
+#include "exynos5250.dtsi"
+#include "cros5250-common.dtsi"
 
 / {
 	model = "Google Snow";
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 4bd9e9c..36c9d8d 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -17,8 +17,8 @@
  * published by the Free Software Foundation.
 */
 
-/include/ "skeleton.dtsi"
-/include/ "exynos5250-pinctrl.dtsi"
+#include "skeleton.dtsi"
+#include "exynos5250-pinctrl.dtsi"
 
 / {
 	compatible = "samsung,exynos5250";
diff --git a/arch/arm/boot/dts/exynos5440-sd5v1.dts b/arch/arm/boot/dts/exynos5440-sd5v1.dts
index ef747b5..5e84c5f 100644
--- a/arch/arm/boot/dts/exynos5440-sd5v1.dts
+++ b/arch/arm/boot/dts/exynos5440-sd5v1.dts
@@ -10,7 +10,7 @@
 */
 
 /dts-v1/;
-/include/ "exynos5440.dtsi"
+#include "exynos5440.dtsi"
 
 / {
 	model = "SAMSUNG SD5v1 board based on EXYNOS5440";
diff --git a/arch/arm/boot/dts/exynos5440-ssdk5440.dts b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
index d55042b..2fd6646 100644
--- a/arch/arm/boot/dts/exynos5440-ssdk5440.dts
+++ b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
@@ -10,7 +10,7 @@
 */
 
 /dts-v1/;
-/include/ "exynos5440.dtsi"
+#include "exynos5440.dtsi"
 
 / {
 	model = "SAMSUNG SSDK5440 board based on EXYNOS5440";
diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
index f6b1c89..13b40b3 100644
--- a/arch/arm/boot/dts/exynos5440.dtsi
+++ b/arch/arm/boot/dts/exynos5440.dtsi
@@ -9,7 +9,7 @@
  * published by the Free Software Foundation.
 */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	compatible = "samsung,exynos5440";
-- 
1.7.4.4
