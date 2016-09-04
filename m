From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  4 Sep 2016 13:04:11 +0200
Subject: [PATCH v3 08/17] ARM: dts: exynos: Use macros for pinctrl
 configuration on exynos5250
In-Reply-To: <1472987060-28293-1-git-send-email-krzk@kernel.org>
References: <1472987060-28293-1-git-send-email-krzk@kernel.org>
Message-ID: <1472987060-28293-9-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Usage of DTS macros instead of hard-coded numbers makes code easier to
read.  One does not have to remember which value means pull-up/down or
specific driver strength.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi     | 402 +++++++++++++-------------
 arch/arm/boot/dts/exynos5250-smdk5250.dts     |   6 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi |  76 ++---
 arch/arm/boot/dts/exynos5250-snow-rev5.dts    |   6 +-
 arch/arm/boot/dts/exynos5250-snow.dts         |   6 +-
 arch/arm/boot/dts/exynos5250-spring.dts       |  72 ++---
 6 files changed, 284 insertions(+), 284 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
index d1a4ea0fb838..2f6ab32b5954 100644
--- a/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5250-pinctrl.dtsi
@@ -202,392 +202,392 @@
 
 	uart0_data: uart0-data {
 		samsung,pins = "gpa0-0", "gpa0-1";
-		samsung,pin-function = <2>;
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
 
 	i2c2_bus: i2c2-bus {
 		samsung,pins = "gpa0-6", "gpa0-7";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	i2c2_hs_bus: i2c2-hs-bus {
 		samsung,pins = "gpa0-6", "gpa0-7";
-		samsung,pin-function = <4>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
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
 
 	uart2_fctl: uart2-fctl {
 		samsung,pins = "gpa1-2", "gpa1-3";
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
 
 	i2c3_hs_bus: i2c3-hs-bus {
 		samsung,pins = "gpa1-2", "gpa1-3";
-		samsung,pin-function = <4>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	uart3_data: uart3-data {
 		samsung,pins = "gpa1-4", "gpa1-4";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	spi0_bus: spi0-bus {
 		samsung,pins = "gpa2-0", "gpa2-2", "gpa2-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	i2c4_bus: i2c4-bus {
 		samsung,pins = "gpa2-0", "gpa2-1";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	i2c5_bus: i2c5-bus {
 		samsung,pins = "gpa2-2", "gpa2-3";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	spi1_bus: spi1-bus {
 		samsung,pins = "gpa2-4", "gpa2-6", "gpa2-7";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	i2s1_bus: i2s1-bus {
 		samsung,pins = "gpb0-0", "gpb0-1", "gpb0-2", "gpb0-3",
 			       "gpb0-4";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	pcm1_bus: pcm1-bus {
 		samsung,pins = "gpb0-0", "gpb0-1", "gpb0-2", "gpb0-3",
 			       "gpb0-4";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	ac97_bus: ac97-bus {
 		samsung,pins = "gpb0-0", "gpb0-1", "gpb0-2", "gpb0-3",
 			       "gpb0-4";
-		samsung,pin-function = <4>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	i2s2_bus: i2s2-bus {
 		samsung,pins = "gpb1-0", "gpb1-1", "gpb1-2", "gpb1-3",
 			       "gpb1-4";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	pcm2_bus: pcm2-bus {
 		samsung,pins = "gpb1-0", "gpb1-1", "gpb1-2", "gpb1-3",
 			       "gpb1-4";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	spdif_bus: spdif-bus {
 		samsung,pins = "gpb1-0", "gpb1-1";
-		samsung,pin-function = <4>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	spi2_bus: spi2-bus {
 		samsung,pins = "gpb1-1", "gpb1-3", "gpb1-4";
-		samsung,pin-function = <5>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_5>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	i2c6_bus: i2c6-bus {
 		samsung,pins = "gpb1-3", "gpb1-4";
-		samsung,pin-function = <4>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	pwm0_out: pwm0-out {
 		samsung,pins = "gpb2-0";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	pwm1_out: pwm1-out {
 		samsung,pins = "gpb2-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	pwm2_out: pwm2-out {
 		samsung,pins = "gpb2-2";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	pwm3_out: pwm3-out {
 		samsung,pins = "gpb2-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	i2c7_bus: i2c7-bus {
 		samsung,pins = "gpb2-2", "gpb2-3";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	i2c0_bus: i2c0-bus {
 		samsung,pins = "gpb3-0", "gpb3-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	i2c1_bus: i2c1-bus {
 		samsung,pins = "gpb3-2", "gpb3-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	i2c0_hs_bus: i2c0-hs-bus {
 		samsung,pins = "gpb3-0", "gpb3-1";
-		samsung,pin-function = <4>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	i2c1_hs_bus: i2c1-hs-bus {
 		samsung,pins = "gpb3-2", "gpb3-3";
-		samsung,pin-function = <4>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	sd0_clk: sd0-clk {
 		samsung,pins = "gpc0-0";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd0_cmd: sd0-cmd {
 		samsung,pins = "gpc0-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd0_cd: sd0-cd {
 		samsung,pins = "gpc0-2";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd0_bus1: sd0-bus-width1 {
 		samsung,pins = "gpc0-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd0_bus4: sd0-bus-width4 {
 		samsung,pins = "gpc0-3", "gpc0-4", "gpc0-5", "gpc0-6";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd0_bus8: sd0-bus-width8 {
 		samsung,pins = "gpc1-0", "gpc1-1", "gpc1-2", "gpc1-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd1_clk: sd1-clk {
 		samsung,pins = "gpc2-0";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd1_cmd: sd1-cmd {
 		samsung,pins = "gpc2-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd1_cd: sd1-cd {
 		samsung,pins = "gpc2-2";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd1_bus1: sd1-bus-width1 {
 		samsung,pins = "gpc2-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd1_bus4: sd1-bus-width4 {
 		samsung,pins = "gpc2-3", "gpc2-4", "gpc2-5", "gpc2-6";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd2_clk: sd2-clk {
 		samsung,pins = "gpc3-0";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd2_cmd: sd2-cmd {
 		samsung,pins = "gpc3-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd2_cd: sd2-cd {
 		samsung,pins = "gpc3-2";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd2_bus1: sd2-bus-width1 {
 		samsung,pins = "gpc3-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd2_bus4: sd2-bus-width4 {
 		samsung,pins = "gpc3-3", "gpc3-4", "gpc3-5", "gpc3-6";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd2_bus8: sd2-bus-width8 {
 		samsung,pins = "gpc4-3", "gpc4-4", "gpc4-5", "gpc4-6";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd3_clk: sd3-clk {
 		samsung,pins = "gpc4-0";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd3_cmd: sd3-cmd {
 		samsung,pins = "gpc4-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd3_cd: sd3-cd {
 		samsung,pins = "gpc4-2";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd3_bus1: sd3-bus-width1 {
 		samsung,pins = "gpc4-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	sd3_bus4: sd3-bus-width4 {
 		samsung,pins = "gpc4-3", "gpc4-4", "gpc4-5", "gpc4-6";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <3>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 	};
 
 	uart1_data: uart1-data {
 		samsung,pins = "gpd0-0", "gpd0-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	uart1_fctl: uart1-fctl {
 		samsung,pins = "gpd0-2", "gpd0-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	dp_hpd: dp_hpd {
 		samsung,pins = "gpx0-7";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 };
 
@@ -668,52 +668,52 @@
 		samsung,pins = "gpe0-0", "gpe0-1", "gpe0-2", "gpe0-3",
 			       "gpe0-4", "gpe0-5", "gpe0-6", "gpe0-7",
 			       "gpe1-0", "gpe1-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	cam_gpio_b: cam-gpio-b {
 		samsung,pins = "gpf0-0", "gpf0-1", "gpf0-2", "gpf0-3",
 			       "gpf1-0", "gpf1-1", "gpf1-2", "gpf1-3";
-		samsung,pin-function = <3>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	cam_i2c2_bus: cam-i2c2-bus {
 		samsung,pins = "gpe0-6", "gpe1-0";
-		samsung,pin-function = <4>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	cam_spi1_bus: cam-spi1-bus {
 		samsung,pins = "gpe0-4", "gpe0-5", "gpf0-2", "gpf0-3";
-		samsung,pin-function = <4>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	cam_i2c1_bus: cam-i2c1-bus {
 		samsung,pins = "gpf0-2", "gpf0-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	cam_i2c0_bus: cam-i2c0-bus {
 		samsung,pins = "gpf0-0", "gpf0-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	cam_spi0_bus: cam-spi0-bus {
 		samsung,pins = "gpf1-0", "gpf1-1", "gpf1-2", "gpf1-3";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	cam_bayrgb_bus: cam-bayrgb-bus {
@@ -722,18 +722,18 @@
 			       "gpg1-0", "gpg1-1", "gpg1-2", "gpg1-3",
 			       "gpg1-4", "gpg1-5", "gpg1-6", "gpg1-7",
 			       "gpg2-0", "gpg2-1";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	cam_port_a: cam-port-a {
 		samsung,pins = "gph0-0", "gph0-1", "gph0-2", "gph0-3",
 			       "gph1-0", "gph1-1", "gph1-2", "gph1-3",
 			       "gph1-4", "gph1-5", "gph1-6", "gph1-7";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 };
 
@@ -783,9 +783,9 @@
 			       "gpv0-4", "gpv0-5", "gpv0-6", "gpv0-7",
 			       "gpv1-0", "gpv1-1", "gpv1-2", "gpv1-3",
 			       "gpv1-4", "gpv1-5", "gpv1-6", "gpv1-7";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	c2c_txd: c2c-txd {
@@ -793,9 +793,9 @@
 			       "gpv2-4", "gpv2-5", "gpv2-6", "gpv2-7",
 			       "gpv3-0", "gpv3-1", "gpv3-2", "gpv3-3",
 			       "gpv3-4", "gpv3-5", "gpv3-6", "gpv3-7";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 };
 
@@ -811,8 +811,8 @@
 	i2s0_bus: i2s0-bus {
 		samsung,pins = "gpz-0", "gpz-1", "gpz-2", "gpz-3",
 				"gpz-4", "gpz-5", "gpz-6";
-		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 };
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 7f27263728a1..ddd51e4afb09 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -416,8 +416,8 @@
 &pinctrl_0 {
 	max77686_irq: max77686-irq {
 		samsung,pins = "gpx3-2";
-		samsung,pin-function = <0xf>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 };
diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
index 1055d25c0ccc..837075b838b5 100644
--- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
@@ -440,7 +440,7 @@
  * double-pulling gets us out of spec in some cases.
  */
 &i2c2_bus {
-	samsung,pin-pud = <0>;
+	samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 };
 
 &i2c_2 {
@@ -572,81 +572,81 @@
 &pinctrl_0 {
 	wifi_en: wifi-en {
 		samsung,pins = "gpx0-1";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	wifi_rst: wifi-rst {
 		samsung,pins = "gpx0-2";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	power_key_irq: power-key-irq {
 		samsung,pins = "gpx1-3";
-		samsung,pin-function = <0xf>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	ec_irq: ec-irq {
 		samsung,pins = "gpx1-6";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	tps65090_irq: tps65090-irq {
 		samsung,pins = "gpx2-6";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	usb3_vbus_en: usb3-vbus-en {
 		samsung,pins = "gpx2-7";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	max77686_irq: max77686-irq {
 		samsung,pins = "gpx3-2";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	lid_irq: lid-irq {
 		samsung,pins = "gpx3-5";
-		samsung,pin-function = <0xf>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	hdmi_hpd_irq: hdmi-hpd-irq {
 		samsung,pins = "gpx3-7";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <1>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 };
 
 &pinctrl_1 {
 	arb_their_claim: arb-their-claim {
 		samsung,pins = "gpe0-4";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	arb_our_claim: arb-our-claim {
 		samsung,pins = "gpf0-3";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 };
 
@@ -657,16 +657,16 @@
 };
 
 &sd3_bus4 {
-	samsung,pin-drv = <0>;
+	samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 };
 
 &sd3_clk {
-	samsung,pin-drv = <0>;
+	samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 };
 
 &sd3_cmd {
-	samsung,pin-pud = <3>;
-	samsung,pin-drv = <0>;
+	samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+	samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 };
 
 &spi_1 {
diff --git a/arch/arm/boot/dts/exynos5250-snow-rev5.dts b/arch/arm/boot/dts/exynos5250-snow-rev5.dts
index f811dc800660..90560c316f64 100644
--- a/arch/arm/boot/dts/exynos5250-snow-rev5.dts
+++ b/arch/arm/boot/dts/exynos5250-snow-rev5.dts
@@ -40,8 +40,8 @@
 &pinctrl_0 {
 	max98090_irq: max98090-irq {
 		samsung,pins = "gpx0-4";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 };
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 995c7ce6c12b..df48f2cc96f7 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -36,8 +36,8 @@
 &pinctrl_0 {
 	max98095_en: max98095-en {
 		samsung,pins = "gpx1-7";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 };
diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
index 1d52a79b2f18..cb390780ac84 100644
--- a/arch/arm/boot/dts/exynos5250-spring.dts
+++ b/arch/arm/boot/dts/exynos5250-spring.dts
@@ -357,7 +357,7 @@
  * double-pulling gets us out of spec in some cases.
  */
 &i2c2_bus {
-	samsung,pin-pud = <0>;
+	samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
 };
 
 &i2c_2 {
@@ -460,92 +460,92 @@
 &pinctrl_0 {
 	s5m8767_dvs: s5m8767-dvs {
 		samsung,pins = "gpd1-0", "gpd1-1", "gpd1-2";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <1>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	dp_hpd_gpio: dp-hpd-gpio {
 		samsung,pins = "gpc3-0";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <3>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	trackpad_irq: trackpad-irq {
 		samsung,pins = "gpx1-2";
-		samsung,pin-function = <0xf>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	power_key_irq: power-key-irq {
 		samsung,pins = "gpx1-3";
-		samsung,pin-function = <0xf>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	ec_irq: ec-irq {
 		samsung,pins = "gpx1-6";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	s5m8767_ds: s5m8767-ds {
 		samsung,pins = "gpx2-3", "gpx2-4", "gpx2-5";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <1>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	s5m8767_irq: s5m8767-irq {
 		samsung,pins = "gpx3-2";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	lid_irq: lid-irq {
 		samsung,pins = "gpx3-5";
-		samsung,pin-function = <0xf>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_F>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 
 	hdmi_hpd_irq: hdmi-hpd-irq {
 		samsung,pins = "gpx3-7";
-		samsung,pin-function = <0>;
-		samsung,pin-pud = <1>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_DOWN>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 };
 
 &pinctrl_1 {
 	hsic_reset: hsic-reset {
 		samsung,pins = "gpe1-0";
-		samsung,pin-function = <1>;
-		samsung,pin-pud = <0>;
-		samsung,pin-drv = <0>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 	};
 };
 
 &sd1_bus4 {
-	samsung,pin-drv = <0>;
+	samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 };
 
 &sd1_cd {
-	samsung,pin-drv = <0>;
+	samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 };
 
 &sd1_clk {
-	samsung,pin-drv = <0>;
+	samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 };
 
 &sd1_cmd {
-	samsung,pin-pud = <3>;
-	samsung,pin-drv = <0>;
+	samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+	samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 };
 
 &spi_1 {
-- 
2.7.4
