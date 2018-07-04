From: jbrunet@baylibre.com (Jerome Brunet)
Date: Wed,  4 Jul 2018 19:04:09 +0200
Subject: [PATCH] ARM64: dts: meson-axg: add spdif output pins
Message-ID: <20180704170409.25809-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the different pin configurations for the spdif output

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 42 ++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 67d7115e4eff..aa1a42407466 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -561,6 +561,48 @@
 					};
 				};
 
+				spdif_out_z_pins: spdif_out_z {
+					mux {
+						groups = "spdif_out_z";
+						function = "spdif_out";
+					};
+				};
+
+				spdif_out_a1_pins: spdif_out_a1 {
+					mux {
+						groups = "spdif_out_a1";
+						function = "spdif_out";
+					};
+				};
+
+				spdif_out_a7_pins: spdif_out_a7 {
+					mux {
+						groups = "spdif_out_a7";
+						function = "spdif_out";
+					};
+				};
+
+				spdif_out_a11_pins: spdif_out_a11 {
+					mux {
+						groups = "spdif_out_a11";
+						function = "spdif_out";
+					};
+				};
+
+				spdif_out_a19_pins: spdif_out_a19 {
+					mux {
+						groups = "spdif_out_a19";
+						function = "spdif_out";
+					};
+				};
+
+				spdif_out_a20_pins: spdif_out_a20 {
+					mux {
+						groups = "spdif_out_a20";
+						function = "spdif_out";
+					};
+				};
+
 				spi0_pins: spi0 {
 					mux {
 						groups = "spi0_miso",
-- 
2.14.4
