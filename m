From: padma.v@samsung.com (Padmavathi Venna)
Date: Mon, 03 Jun 2013 10:49:01 +0530
Subject: [PATCH V4 1/4] ARM: samsung: use #include for all device trees
In-Reply-To: <1370236744-16802-1-git-send-email-padma.v@samsung.com>
References: <1370236744-16802-1-git-send-email-padma.v@samsung.com>
Message-ID: <1370236744-16802-2-git-send-email-padma.v@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace /include/ (dtc) with #include (C pre-processor) for all
Samsung DT files

Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi                  |    2 +-
 arch/arm/boot/dts/exynos4210-origen.dts         |    2 +-
 arch/arm/boot/dts/exynos4210-smdkv310.dts       |    2 +-
 arch/arm/boot/dts/exynos4210-trats.dts          |    2 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts |    2 +-
 arch/arm/boot/dts/exynos4210.dtsi               |    4 ++--
 arch/arm/boot/dts/exynos4212.dtsi               |    2 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts        |    2 +-
 arch/arm/boot/dts/exynos4412-origen.dts         |    2 +-
 arch/arm/boot/dts/exynos4412-smdk4412.dts       |    2 +-
 arch/arm/boot/dts/exynos4412.dtsi               |    2 +-
 arch/arm/boot/dts/exynos4x12.dtsi               |    4 ++--
 arch/arm/boot/dts/exynos5250-arndale.dts        |    2 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts       |    2 +-
 arch/arm/boot/dts/exynos5250-snow.dts           |    4 ++--
 arch/arm/boot/dts/exynos5250.dtsi               |    4 ++--
 arch/arm/boot/dts/exynos5440-sd5v1.dts          |    2 +-
 arch/arm/boot/dts/exynos5440-ssdk5440.dts       |    2 +-
 arch/arm/boot/dts/exynos5440.dtsi               |    2 +-
 arch/arm/boot/dts/s3c2416-smdk2416.dts          |    2 +-
 arch/arm/boot/dts/s3c2416.dtsi                  |    4 ++--
 arch/arm/boot/dts/s3c24xx.dtsi                  |    2 +-
 22 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index bed40ee..3f94fe8 100644
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
index bcf8079..5f851d7 100644
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
diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 345cdb5..889cdad 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -13,7 +13,7 @@
 */
 
 /dts-v1/;
-/include/ "exynos4210.dtsi"
+#include "exynos4210.dtsi"
 
 / {
 	model = "Samsung Universal C210 based on Exynos4210 rev0";
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 366795a..75c2756 100644
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
index c0f60f4..6f34d7f 100644
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
index 53bc8bf..7bb8d48 100644
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
index 790a999..df097b5 100644
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
index 270b389..e743e67 100644
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
index 3e0c792..f2a025e 100644
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
index d449feb..fd711e2 100644
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
index 9dfc6de..bccda67 100644
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
diff --git a/arch/arm/boot/dts/s3c2416-smdk2416.dts b/arch/arm/boot/dts/s3c2416-smdk2416.dts
index ad1dd09..59594cf 100644
--- a/arch/arm/boot/dts/s3c2416-smdk2416.dts
+++ b/arch/arm/boot/dts/s3c2416-smdk2416.dts
@@ -9,7 +9,7 @@
  */
 
 /dts-v1/;
-/include/ "s3c2416.dtsi"
+#include "s3c2416.dtsi"
 
 / {
 	model = "SMDK2416";
diff --git a/arch/arm/boot/dts/s3c2416.dtsi b/arch/arm/boot/dts/s3c2416.dtsi
index 6809324..e6555bd 100644
--- a/arch/arm/boot/dts/s3c2416.dtsi
+++ b/arch/arm/boot/dts/s3c2416.dtsi
@@ -8,8 +8,8 @@
  * published by the Free Software Foundation.
  */
 
-/include/ "s3c24xx.dtsi"
-/include/ "s3c2416-pinctrl.dtsi"
+#include "s3c24xx.dtsi"
+#include "s3c2416-pinctrl.dtsi"
 
 / {
 	model = "Samsung S3C2416 SoC";
diff --git a/arch/arm/boot/dts/s3c24xx.dtsi b/arch/arm/boot/dts/s3c24xx.dtsi
index cab46ff..2d1d7dc 100644
--- a/arch/arm/boot/dts/s3c24xx.dtsi
+++ b/arch/arm/boot/dts/s3c24xx.dtsi
@@ -8,7 +8,7 @@
  * published by the Free Software Foundation.
  */
 
-/include/ "skeleton.dtsi"
+#include "skeleton.dtsi"
 
 / {
 	compatible = "samsung,s3c24xx";
-- 
1.7.4.4
