From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 16 Jul 2018 12:11:49 +0200
Subject: [PATCH 4/6] ARM64: dts: meson-axg: add spdif input pins
In-Reply-To: <20180716101151.31109-1-jbrunet@baylibre.com>
References: <20180716101151.31109-1-jbrunet@baylibre.com>
Message-ID: <20180716101151.31109-5-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add spdif input pin definitions to meson AXG

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 35 ++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index cc908c9b5306..277958ff516a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -561,6 +561,41 @@
 					};
 				};
 
+				spdif_in_z_pins: spdif_in_z {
+					mux {
+						groups = "spdif_in_z";
+						function = "spdif_in";
+					};
+				};
+
+				spdif_in_a1_pins: spdif_in_a1 {
+					mux {
+						groups = "spdif_in_a1";
+						function = "spdif_in";
+					};
+				};
+
+				spdif_in_a7_pins: spdif_in_a7 {
+					mux {
+						groups = "spdif_in_a7";
+						function = "spdif_in";
+					};
+				};
+
+				spdif_in_a19_pins: spdif_in_a19 {
+					mux {
+						groups = "spdif_in_a19";
+						function = "spdif_in";
+					};
+				};
+
+				spdif_in_a20_pins: spdif_in_a20 {
+					mux {
+						groups = "spdif_in_a20";
+						function = "spdif_in";
+					};
+				};
+
 				spdif_out_z_pins: spdif_out_z {
 					mux {
 						groups = "spdif_out_z";
-- 
2.14.4
