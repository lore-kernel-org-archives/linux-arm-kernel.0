From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 20 Nov 2017 22:54:14 +0800
Subject: [PATCH v2 4/5] ARM64: dts: meson-axg: describe pin DT info for I2C
 controller
In-Reply-To: <20171120145415.6581-1-yixun.lan@amlogic.com>
References: <20171120145415.6581-1-yixun.lan@amlogic.com>
Message-ID: <20171120145415.6581-5-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jian Hu <jian.hu@amlogic.com>

Describe all the pin mux for the I2C controller which found in
Meson-AXG SoC.

Signed-off-by: Jian Hu <jian.hu@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 64 ++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index b8ddec6e2cbe..51e2262e5277 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -304,6 +304,70 @@
 						function = "eth";
 					};
 				};
+
+				i2c0_pins: i2c0 {
+					mux {
+						groups = "i2c0_sck",
+							"i2c0_sda";
+						function = "i2c0";
+					};
+				};
+
+				i2c1_z_pins: i2c1_z {
+					mux {
+						groups = "i2c1_sck_z",
+							"i2c1_sda_z";
+						function = "i2c1";
+					};
+				};
+
+				i2c1_x_pins: i2c1_x {
+					mux {
+						groups = "i2c1_sck_x",
+							"i2c1_sda_x";
+						function = "i2c1";
+					};
+				};
+
+				i2c2_x_pins: i2c2_x {
+					mux {
+						groups = "i2c2_sck_x",
+							"i2c2_sda_x";
+						function = "i2c2";
+					};
+				};
+
+				i2c2_a_pins: i2c2_a {
+					mux {
+						groups = "i2c2_sck_a",
+							"i2c2_sda_a";
+						function = "i2c2";
+					};
+				};
+
+				i2c3_a6_pins: i2c3_a6 {
+					mux {
+						groups = "i2c3_sda_a6",
+							"i2c3_sck_a7";
+						function = "i2c3";
+					};
+				};
+
+				i2c3_a12_pins: i2c3_a12 {
+					mux {
+						groups = "i2c3_sda_a12",
+							"i2c3_sck_a13";
+						function = "i2c3";
+					};
+				};
+
+				i2c3_a19_pins: i2c3_a19 {
+					mux {
+						groups = "i2c3_sda_a19",
+							"i2c3_sck_a20";
+						function = "i2c3";
+					};
+				};
 			};
 		};
 
-- 
2.15.0
