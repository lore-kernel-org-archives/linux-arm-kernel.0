From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 28 Sep 2015 13:37:47 +0100
Subject: [PATCH v2 11/11] ARM: STi: STiH407: Add spi default pinctrl groups.
In-Reply-To: <1443443867-4099-1-git-send-email-peter.griffin@linaro.org>
References: <1443443867-4099-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1443443867-4099-12-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now we have default pinconfig groups for each SPI
controller ensure it is used by the SPI controller
node.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih407-family.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index ae05277..4d60e7d 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -396,6 +396,8 @@
 			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
 			clock-names = "ssc";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi1_default>;
 
 			status = "disabled";
 		};
@@ -406,6 +408,8 @@
 			interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
 			clock-names = "ssc";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi2_default>;
 
 			status = "disabled";
 		};
@@ -416,6 +420,8 @@
 			interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
 			clock-names = "ssc";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi3_default>;
 
 			status = "disabled";
 		};
@@ -426,6 +432,8 @@
 			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_s_c0_flexgen CLK_EXT2F_A9>;
 			clock-names = "ssc";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi4_default>;
 
 			status = "disabled";
 		};
@@ -437,6 +445,8 @@
 			interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_sysin>;
 			clock-names = "ssc";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi10_default>;
 
 			status = "disabled";
 		};
@@ -447,6 +457,8 @@
 			interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_sysin>;
 			clock-names = "ssc";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi11_default>;
 
 			status = "disabled";
 		};
@@ -457,6 +469,8 @@
 			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_sysin>;
 			clock-names = "ssc";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_spi12_default>;
 
 			status = "disabled";
 		};
-- 
1.9.1
