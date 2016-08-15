From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 15 Aug 2016 13:17:36 +0100
Subject: [PATCH 3/7] ARM: dts: STiH407-pinctrl: Add i2c2_alt2_1 node
In-Reply-To: <20160815121740.29515-1-lee.jones@linaro.org>
References: <20160815121740.29515-1-lee.jones@linaro.org>
Message-ID: <20160815121740.29515-4-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Add missing pin muxing for I2C2 alternate 2. This
i2c2 pin muxing is dedicated for 96board high speed
expansion connector.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
[Lee: Correct spacing between nodes]
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index bd53c74..e05be3c 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -523,6 +523,13 @@
 						scl = <&pio15 5 ALT2 BIDIR>;
 					};
 				};
+
+				pinctrl_i2c2_alt2_1: i2c2-alt2-1 {
+					st,pins {
+						sda = <&pio12 6 ALT2 BIDIR>;
+						scl = <&pio12 5 ALT2 BIDIR>;
+					};
+				};
 			};
 
 			i2c3 {
-- 
2.9.0
