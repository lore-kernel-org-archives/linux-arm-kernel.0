From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 23 Aug 2016 13:25:08 +0200
Subject: [PATCH v2 2/2] ARM64: dts: meson-gxbb: Add PWM pinctrl nodes
In-Reply-To: <1471951508-29620-1-git-send-email-narmstrong@baylibre.com>
References: <1471951508-29620-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1471951508-29620-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT nodes for PWMs in EE and AO domains.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 77 +++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index e502c24..9aeb88a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -203,6 +203,34 @@
 						function = "uart_ao";
 					};
 				};
+
+				pwm_ao_a_3_pins: pwm_ao_a_3 {
+					mux {
+						groups = "pwm_ao_a_3";
+						function = "pwm_ao_a_3";
+					};
+				};
+
+				pwm_ao_a_6_pins: pwm_ao_a_6 {
+					mux {
+						groups = "pwm_ao_a_6";
+						function = "pwm_ao_a_6";
+					};
+				};
+
+				pwm_ao_a_12_pins: pwm_ao_a_12 {
+					mux {
+						groups = "pwm_ao_a_12";
+						function = "pwm_ao_a_12";
+					};
+				};
+
+				pwm_ao_b_pins: pwm_ao_b {
+					mux {
+						groups = "pwm_ao_b";
+						function = "pwm_ao_b";
+					};
+				};
 			};
 
 			uart_AO: serial at 4c0 {
@@ -306,6 +334,55 @@
 						function = "eth";
 					};
 				};
+
+				pwm_a_x_pins: pwm_a_x {
+					mux {
+						groups = "pwm_a_x";
+						function = "pwm_a_x";
+					};
+				};
+
+				pwm_a_y_pins: pwm_a_y {
+					mux {
+						groups = "pwm_a_y";
+						function = "pwm_a_y";
+					};
+				};
+
+				pwm_b_pins: pwm_b {
+					mux {
+						groups = "pwm_b";
+						function = "pwm_b";
+					};
+				};
+
+				pwm_d_pins: pwm_d {
+					mux {
+						groups = "pwm_d";
+						function = "pwm_d";
+					};
+				};
+
+				pwm_e_pins: pwm_e {
+					mux {
+						groups = "pwm_e";
+						function = "pwm_e";
+					};
+				};
+
+				pwm_f_x_pins: pwm_f_x {
+					mux {
+						groups = "pwm_f_x";
+						function = "pwm_f_x";
+					};
+				};
+
+				pwm_f_y_pins: pwm_f_y {
+					mux {
+						groups = "pwm_f_y";
+						function = "pwm_f_y";
+					};
+				};
 			};
 		};
 
-- 
1.9.1
