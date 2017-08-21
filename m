From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 21 Aug 2017 18:06:30 +0200
Subject: [PATCH v2 2/9] ARM64: dts: meson: remove cap-sd-highspeed from emmc
 nodes
In-Reply-To: <20170821160637.22456-1-jbrunet@baylibre.com>
References: <20170821160637.22456-1-jbrunet@baylibre.com>
Message-ID: <20170821160637.22456-3-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It does not make much sense to define cap-sd-highspeed in the emmc nodes
Just remove it.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi            | 1 -
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts           | 1 -
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts         | 1 -
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts            | 1 -
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi               | 1 -
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi           | 1 -
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts | 1 -
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    | 1 -
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi          | 1 -
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts            | 1 -
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts             | 1 -
 11 files changed, 11 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
index dc478d094c11..cff39c5a2632 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -208,7 +208,6 @@
 	pinctrl-names = "default";
 
 	bus-width = <8>;
-	cap-sd-highspeed;
 	cap-mmc-highspeed;
 	max-frequency = <200000000>;
 	non-removable;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index fa462831ccaf..b48a4576158a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -239,7 +239,6 @@
 	pinctrl-names = "default";
 
 	bus-width = <8>;
-	cap-sd-highspeed;
 	max-frequency = <200000000>;
 	non-removable;
 	disable-wp;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index a1078b3e1c76..c64c2256d092 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -267,7 +267,6 @@
 	pinctrl-names = "default";
 
 	bus-width = <8>;
-	cap-sd-highspeed;
 	cap-mmc-highspeed;
 	max-frequency = <200000000>;
 	non-removable;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index d147c853ab05..a12303becab4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -274,7 +274,6 @@
 	pinctrl-names = "default";
 
 	bus-width = <8>;
-	cap-sd-highspeed;
 	max-frequency = <200000000>;
 	non-removable;
 	disable-wp;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index 58b32f272a0e..30b880b694de 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -234,7 +234,6 @@
 	pinctrl-names = "default";
 
 	bus-width = <8>;
-	cap-sd-highspeed;
 	cap-mmc-highspeed;
 	max-frequency = <200000000>;
 	non-removable;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 346753fb6324..0262ef8d48e4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -201,7 +201,6 @@
 	pinctrl-names = "default";
 
 	bus-width = <8>;
-	cap-sd-highspeed;
 	cap-mmc-highspeed;
 	max-frequency = <200000000>;
 	non-removable;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
index 2a5804ce7f4b..f779a985f923 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts
@@ -144,7 +144,6 @@
 	pinctrl-names = "default";
 
 	bus-width = <8>;
-	cap-sd-highspeed;
 	cap-mmc-highspeed;
 	max-frequency = <100000000>;
 	non-removable;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
index 6633a5d8fdd3..83c35efbae8b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
@@ -224,7 +224,6 @@
 	pinctrl-names = "default";
 
 	bus-width = <8>;
-	cap-sd-highspeed;
 	cap-mmc-highspeed;
 	max-frequency = <200000000>;
 	non-removable;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
index f3eea8e89d12..8899121f79e1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi
@@ -137,7 +137,6 @@
 	pinctrl-names = "default";
 
 	bus-width = <8>;
-	cap-sd-highspeed;
 	cap-mmc-highspeed;
 	max-frequency = <200000000>;
 	non-removable;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
index 5f626d683088..583da09acf66 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -189,7 +189,6 @@
 	pinctrl-names = "default";
 
 	bus-width = <8>;
-	cap-sd-highspeed;
 	cap-mmc-highspeed;
 	max-frequency = <200000000>;
 	non-removable;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
index 08f1dd69b679..470f72bb863c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
@@ -220,7 +220,6 @@
 	pinctrl-names = "default";
 
 	bus-width = <8>;
-	cap-sd-highspeed;
 	cap-mmc-highspeed;
 	max-frequency = <200000000>;
 	non-removable;
-- 
2.9.5
