From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 18 Mar 2017 13:27:36 +0100
Subject: [PATCH v2 2/2] ARM64: dts: amlogic: meson-gxl: add the missing PWM
 pins
In-Reply-To: <20170318122736.11592-1-martin.blumenstingl@googlemail.com>
References: <20170304212318.27076-1-martin.blumenstingl@googlemail.com>
 <20170318122736.11592-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170318122736.11592-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the new DT nodes for the missing PWM pins in the EE and AO
domain.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 56 ++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index fe11b5fc61f7..79c387a16fa2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -118,6 +118,20 @@
 			};
 		};
 
+		pwm_ao_a_3_pins: pwm_ao_a_3 {
+			mux {
+				groups = "pwm_ao_a_3";
+				function = "pwm_ao_a";
+			};
+		};
+
+		pwm_ao_a_8_pins: pwm_ao_a_8 {
+			mux {
+				groups = "pwm_ao_a_8";
+				function = "pwm_ao_a";
+			};
+		};
+
 		pwm_ao_b_pins: pwm_ao_b {
 			mux {
 				groups = "pwm_ao_b";
@@ -277,6 +291,34 @@
 			};
 		};
 
+		pwm_a_pins: pwm_a {
+			mux {
+				groups = "pwm_a";
+				function = "pwm_a";
+			};
+		};
+
+		pwm_b_pins: pwm_b {
+			mux {
+				groups = "pwm_b";
+				function = "pwm_b";
+			};
+		};
+
+		pwm_c_pins: pwm_c {
+			mux {
+				groups = "pwm_c";
+				function = "pwm_c";
+			};
+		};
+
+		pwm_d_pins: pwm_d {
+			mux {
+				groups = "pwm_d";
+				function = "pwm_d";
+			};
+		};
+
 		pwm_e_pins: pwm_e {
 			mux {
 				groups = "pwm_e";
@@ -284,6 +326,20 @@
 			};
 		};
 
+		pwm_f_clk_pins: pwm_f_clk {
+			mux {
+				groups = "pwm_f_clk";
+				function = "pwm_f";
+			};
+		};
+
+		pwm_f_x_pins: pwm_f_x {
+			mux {
+				groups = "pwm_f_x";
+				function = "pwm_f";
+			};
+		};
+
 		hdmi_hpd_pins: hdmi_hpd {
 			mux {
 				groups = "hdmi_hpd";
-- 
2.12.0
