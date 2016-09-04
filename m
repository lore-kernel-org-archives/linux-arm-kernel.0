From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  4 Sep 2016 13:04:07 +0200
Subject: [PATCH v3 04/17] ARM: dts: exynos: Use macros for pinctrl
 configuration on exynos3250
In-Reply-To: <1472987060-28293-1-git-send-email-krzk@kernel.org>
References: <1472987060-28293-1-git-send-email-krzk@kernel.org>
Message-ID: <1472987060-28293-5-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Usage of DTS macros instead of hard-coded numbers makes code easier to
read.  One does not have to remember which value means pull-up/down or
specific driver strength.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi | 270 +++++++++++++++---------------
 1 file changed, 135 insertions(+), 135 deletions(-)

diff --git a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
index ed22d94f4fe5..ec331169c3d9 100644
--- a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
@@ -113,158 +113,158 @@
 
 	uart0_data: uart0-data {
 		samsung,pins = "gpa0-0", "gpa0-1";
-		samsung,pin-function = <0x2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	uart0_fctl: uart0-fctl {
 		samsung,pins = "gpa0-2", "gpa0-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	uart1_data: uart1-data {
 		samsung,pins = "gpa0-4", "gpa0-5";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	uart1_fctl: uart1-fctl {
 		samsung,pins = "gpa0-6", "gpa0-7";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	i2c2_bus: i2c2-bus {
 		samsung,pins = "gpa0-6", "gpa0-7";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	uart2_data: uart2-data {
 		samsung,pins = "gpa1-0", "gpa1-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	i2c3_bus: i2c3-bus {
 		samsung,pins = "gpa1-2", "gpa1-3";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	spi0_bus: spi0-bus {
 		samsung,pins = "gpb-0", "gpb-2", "gpb-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	i2c4_bus: i2c4-bus {
 		samsung,pins = "gpb-0", "gpb-1";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	spi1_bus: spi1-bus {
 		samsung,pins = "gpb-4", "gpb-6", "gpb-7";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	i2c5_bus: i2c5-bus {
 		samsung,pins = "gpb-2", "gpb-3";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	i2s2_bus: i2s2-bus {
 		samsung,pins = "gpc1-0", "gpc1-1", "gpc1-2", "gpc1-3",
 				"gpc1-4";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	pcm2_bus: pcm2-bus {
 		samsung,pins = "gpc1-0", "gpc1-1", "gpc1-2", "gpc1-3",
 				"gpc1-4";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	i2c6_bus: i2c6-bus {
 		samsung,pins = "gpc1-3", "gpc1-4";
-		samsung,pin-function = <4>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	pwm0_out: pwm0-out {
 		samsung,pins = "gpd0-0";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	pwm1_out: pwm1-out {
 		samsung,pins = "gpd0-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	i2c7_bus: i2c7-bus {
 		samsung,pins = "gpd0-2", "gpd0-3";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	pwm2_out: pwm2-out {
 		samsung,pins = "gpd0-2";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	pwm3_out: pwm3-out {
 		samsung,pins = "gpd0-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	i2c0_bus: i2c0-bus {
 		samsung,pins = "gpd1-0", "gpd1-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	mipi0_clk: mipi0-clk {
 		samsung,pins = "gpd1-0", "gpd1-1";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	i2c1_bus: i2c1-bus {
 		samsung,pins = "gpd1-2", "gpd1-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 };
 
@@ -396,164 +396,164 @@
 
 	sd0_clk: sd0-clk {
 		samsung,pins = "gpk0-0";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd0_cmd: sd0-cmd {
 		samsung,pins = "gpk0-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd0_cd: sd0-cd {
 		samsung,pins = "gpk0-2";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd0_rdqs: sd0-rdqs {
 		samsung,pins = "gpk0-7";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd0_bus1: sd0-bus-width1 {
 		samsung,pins = "gpk0-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd0_bus4: sd0-bus-width4 {
 		samsung,pins = "gpk0-4", "gpk0-5", "gpk0-6";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd0_bus8: sd0-bus-width8 {
 		samsung,pins = "gpl0-0", "gpl0-1", "gpl0-2", "gpl0-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd1_clk: sd1-clk {
 		samsung,pins = "gpk1-0";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd1_cmd: sd1-cmd {
 		samsung,pins = "gpk1-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd1_cd: sd1-cd {
 		samsung,pins = "gpk1-2";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd1_bus1: sd1-bus-width1 {
 		samsung,pins = "gpk1-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd1_bus4: sd1-bus-width4 {
 		samsung,pins = "gpk1-4", "gpk1-5", "gpk1-6";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd2_clk: sd2-clk {
 		samsung,pins = "gpk2-0";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd2_cmd: sd2-cmd {
 		samsung,pins = "gpk2-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd2_cd: sd2-cd {
 		samsung,pins = "gpk2-2";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd2_bus1: sd2-bus-width1 {
 		samsung,pins = "gpk2-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd2_bus4: sd2-bus-width4 {
 		samsung,pins = "gpk2-4", "gpk2-5", "gpk2-6";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	cam_port_b_io: cam-port-b-io {
 		samsung,pins = "gpm0-0", "gpm0-1", "gpm0-2", "gpm0-3",
 				"gpm0-4", "gpm0-5", "gpm0-6", "gpm0-7",
 				"gpm1-0", "gpm1-1", "gpm2-0", "gpm2-1";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	cam_port_b_clk_active: cam-port-b-clk-active {
 		samsung,pins = "gpm2-2";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	cam_port_b_clk_idle: cam-port-b-clk-idle {
 		samsung,pins = "gpm2-2";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	fimc_is_i2c0: fimc-is-i2c0 {
 		samsung,pins = "gpm4-0", "gpm4-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	fimc_is_i2c1: fimc-is-i2c1 {
 		samsung,pins = "gpm4-2", "gpm4-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	fimc_is_uart: fimc-is-uart {
 		samsung,pins = "gpm3-5", "gpm3-7";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 };
-- 
2.7.4
