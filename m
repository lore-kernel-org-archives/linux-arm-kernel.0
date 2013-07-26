From: josephl@nvidia.com (Joseph Lo)
Date: Fri, 26 Jul 2013 17:15:10 +0800
Subject: [PATCH 8/8] ARM: dts: tegra: enable LP1 suspend mode
In-Reply-To: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
References: <1374830110-30685-1-git-send-email-josephl@nvidia.com>
Message-ID: <1374830110-30685-9-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enabling the LP1 suspend mode for Tegra devices.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts     | 2 +-
 arch/arm/boot/dts/tegra20-colibri-512.dtsi | 2 +-
 arch/arm/boot/dts/tegra20-harmony.dts      | 2 +-
 arch/arm/boot/dts/tegra20-paz00.dts        | 2 +-
 arch/arm/boot/dts/tegra20-seaboard.dts     | 2 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi    | 2 +-
 arch/arm/boot/dts/tegra20-trimslice.dts    | 2 +-
 arch/arm/boot/dts/tegra20-ventana.dts      | 2 +-
 arch/arm/boot/dts/tegra20-whistler.dts     | 2 +-
 arch/arm/boot/dts/tegra30-beaver.dts       | 2 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi      | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index aeda147..a2a1b5f 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -1024,7 +1024,7 @@
 
 	pmc {
 		nvidia,invert-interrupt;
-		nvidia,suspend-mode = <2>;
+		nvidia,suspend-mode = <1>;
 		nvidia,cpu-pwr-good-time = <500>;
 		nvidia,cpu-pwr-off-time = <300>;
 		nvidia,core-pwr-good-time = <641 3845>;
diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
index 2fcb3f2..06c5fa0 100644
--- a/arch/arm/boot/dts/tegra20-colibri-512.dtsi
+++ b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
@@ -363,7 +363,7 @@
 	};
 
 	pmc {
-		nvidia,suspend-mode = <2>;
+		nvidia,suspend-mode = <1>;
 		nvidia,cpu-pwr-good-time = <5000>;
 		nvidia,cpu-pwr-off-time = <5000>;
 		nvidia,core-pwr-good-time = <3845 3845>;
diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index d9f89cd..d44cf90 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -417,7 +417,7 @@
 
 	pmc {
 		nvidia,invert-interrupt;
-		nvidia,suspend-mode = <2>;
+		nvidia,suspend-mode = <1>;
 		nvidia,cpu-pwr-good-time = <5000>;
 		nvidia,cpu-pwr-off-time = <5000>;
 		nvidia,core-pwr-good-time = <3845 3845>;
diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index cfd1276..8d71fc9 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -417,7 +417,7 @@
 
 	pmc {
 		nvidia,invert-interrupt;
-		nvidia,suspend-mode = <2>;
+		nvidia,suspend-mode = <1>;
 		nvidia,cpu-pwr-good-time = <2000>;
 		nvidia,cpu-pwr-off-time = <0>;
 		nvidia,core-pwr-good-time = <3845 3845>;
diff --git a/arch/arm/boot/dts/tegra20-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
index 365760b..152dfb7 100644
--- a/arch/arm/boot/dts/tegra20-seaboard.dts
+++ b/arch/arm/boot/dts/tegra20-seaboard.dts
@@ -518,7 +518,7 @@
 
 	pmc {
 		nvidia,invert-interrupt;
-		nvidia,suspend-mode = <2>;
+		nvidia,suspend-mode = <1>;
 		nvidia,cpu-pwr-good-time = <5000>;
 		nvidia,cpu-pwr-off-time = <5000>;
 		nvidia,core-pwr-good-time = <3845 3845>;
diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi
index c54faae..f00febe 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
@@ -459,7 +459,7 @@
 
 	pmc {
 		nvidia,invert-interrupt;
-		nvidia,suspend-mode = <2>;
+		nvidia,suspend-mode = <1>;
 		nvidia,cpu-pwr-good-time = <5000>;
 		nvidia,cpu-pwr-off-time = <5000>;
 		nvidia,core-pwr-good-time = <3845 3845>;
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index ed4b901..3e4eefb 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -302,7 +302,7 @@
 	};
 
 	pmc {
-		nvidia,suspend-mode = <2>;
+		nvidia,suspend-mode = <1>;
 		nvidia,cpu-pwr-good-time = <5000>;
 		nvidia,cpu-pwr-off-time = <5000>;
 		nvidia,core-pwr-good-time = <3845 3845>;
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index 7f8c28d..aab872c 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -494,7 +494,7 @@
 
 	pmc {
 		nvidia,invert-interrupt;
-		nvidia,suspend-mode = <2>;
+		nvidia,suspend-mode = <1>;
 		nvidia,cpu-pwr-good-time = <2000>;
 		nvidia,cpu-pwr-off-time = <100>;
 		nvidia,core-pwr-good-time = <3845 3845>;
diff --git a/arch/arm/boot/dts/tegra20-whistler.dts b/arch/arm/boot/dts/tegra20-whistler.dts
index ab67c94..3899cae 100644
--- a/arch/arm/boot/dts/tegra20-whistler.dts
+++ b/arch/arm/boot/dts/tegra20-whistler.dts
@@ -497,7 +497,7 @@
 
 	pmc {
 		nvidia,invert-interrupt;
-		nvidia,suspend-mode = <2>;
+		nvidia,suspend-mode = <1>;
 		nvidia,cpu-pwr-good-time = <2000>;
 		nvidia,cpu-pwr-off-time = <1000>;
 		nvidia,core-pwr-good-time = <0 3845>;
diff --git a/arch/arm/boot/dts/tegra30-beaver.dts b/arch/arm/boot/dts/tegra30-beaver.dts
index 87c5f7b..7378927 100644
--- a/arch/arm/boot/dts/tegra30-beaver.dts
+++ b/arch/arm/boot/dts/tegra30-beaver.dts
@@ -262,7 +262,7 @@
 	pmc {
 		status = "okay";
 		nvidia,invert-interrupt;
-		nvidia,suspend-mode = <2>;
+		nvidia,suspend-mode = <1>;
 		nvidia,cpu-pwr-good-time = <2000>;
 		nvidia,cpu-pwr-off-time = <200>;
 		nvidia,core-pwr-good-time = <3845 3845>;
diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi
index c011b67..d78c90c 100644
--- a/arch/arm/boot/dts/tegra30-cardhu.dtsi
+++ b/arch/arm/boot/dts/tegra30-cardhu.dtsi
@@ -314,7 +314,7 @@
 	pmc {
 		status = "okay";
 		nvidia,invert-interrupt;
-		nvidia,suspend-mode = <2>;
+		nvidia,suspend-mode = <1>;
 		nvidia,cpu-pwr-good-time = <2000>;
 		nvidia,cpu-pwr-off-time = <200>;
 		nvidia,core-pwr-good-time = <3845 3845>;
-- 
1.8.3.4
