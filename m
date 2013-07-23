From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 23 Jul 2013 11:36:14 +0200
Subject: [PATCH] ARM: rockchip: remove obsolete rockchip,config properties
Message-ID: <201307231136.14603.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These were used only in one intermediate variant of the pinctrl
driver but forgotten in the dtsi file. rockchip,config properties are
neither part of the actual binding nor handled by the pinctrl driver
at all, so remove them.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a.dtsi |   22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 457f380..258197e 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -213,17 +213,14 @@
 				uart0_xfer: uart0-xfer {
 					rockchip,pins = <RK_GPIO1 0 RK_FUNC_1 &pcfg_pull_default>,
 							<RK_GPIO1 1 RK_FUNC_1 &pcfg_pull_default>;
-					rockchip,config = <&pcfg_pull_default>;
 				};
 
 				uart0_cts: uart0-cts {
 					rockchip,pins = <RK_GPIO1 2 RK_FUNC_1 &pcfg_pull_default>;
-					rockchip,config = <&pcfg_pull_default>;
 				};
 
 				uart0_rts: uart0-rts {
 					rockchip,pins = <RK_GPIO1 3 RK_FUNC_1 &pcfg_pull_default>;
-					rockchip,config = <&pcfg_pull_default>;
 				};
 			};
 
@@ -231,17 +228,14 @@
 				uart1_xfer: uart1-xfer {
 					rockchip,pins = <RK_GPIO1 4 RK_FUNC_1 &pcfg_pull_default>,
 							<RK_GPIO1 5 RK_FUNC_1 &pcfg_pull_default>;
-					rockchip,config = <&pcfg_pull_default>;
 				};
 
 				uart1_cts: uart1-cts {
 					rockchip,pins = <RK_GPIO1 6 RK_FUNC_1 &pcfg_pull_default>;
-					rockchip,config = <&pcfg_pull_default>;
 				};
 
 				uart1_rts: uart1-rts {
 					rockchip,pins = <RK_GPIO1 7 RK_FUNC_1 &pcfg_pull_default>;
-					rockchip,config = <&pcfg_pull_default>;
 				};
 			};
 
@@ -249,7 +243,6 @@
 				uart2_xfer: uart2-xfer {
 					rockchip,pins = <RK_GPIO1 8 RK_FUNC_1 &pcfg_pull_default>,
 							<RK_GPIO1 9 RK_FUNC_1 &pcfg_pull_default>;
-					rockchip,config = <&pcfg_pull_default>;
 				};
 				/* no rts / cts for uart2 */
 			};
@@ -258,44 +251,36 @@
 				uart3_xfer: uart3-xfer {
 					rockchip,pins = <RK_GPIO3 27 RK_FUNC_1 &pcfg_pull_default>,
 							<RK_GPIO3 28 RK_FUNC_1 &pcfg_pull_default>;
-					rockchip,config = <&pcfg_pull_default>;
 				};
 
 				uart3_cts: uart3-cts {
 					rockchip,pins = <RK_GPIO3 29 RK_FUNC_1 &pcfg_pull_default>;
-					rockchip,config = <&pcfg_pull_default>;
 				};
 
 				uart3_rts: uart3-rts {
 					rockchip,pins = <RK_GPIO3 30 RK_FUNC_1 &pcfg_pull_default>;
-					rockchip,config = <&pcfg_pull_default>;
 				};
 			};
 
 			sd0 {
 				sd0_clk: sd0-clk {
 					rockchip,pins = <RK_GPIO3 8 RK_FUNC_1 &pcfg_pull_default>;
-					rockchip,config = <&pcfg_pull_default>;
 				};
 
 				sd0_cmd: sd0-cmd {
 					rockchip,pins = <RK_GPIO3 9 RK_FUNC_1 &pcfg_pull_default>;
-					rockchip,config = <&pcfg_pull_default>;
 				};
 
 				sd0_cd: sd0-cd {
 					rockchip,pins = <RK_GPIO3 14 RK_FUNC_1 &pcfg_pull_default>;
-					rockchip,config = <&pcfg_pull_default>;
 				};
 
 				sd0_wp: sd0-wp {
 					rockchip,pins = <RK_GPIO3 15 RK_FUNC_1 &pcfg_pull_default>;
-					rockchip,config = <&pcfg_pull_default>;
 				};
 
 				sd0_bus1: sd0-bus-width1 {
 					rockchip,pins = <RK_GPIO3 10 RK_FUNC_1 &pcfg_pull_default>;
-					rockchip,config = <&pcfg_pull_default>;
 				};
 
 				sd0_bus4: sd0-bus-width4 {
@@ -303,34 +288,28 @@
 							<RK_GPIO3 11 RK_FUNC_1 &pcfg_pull_default>,
 							<RK_GPIO3 12 RK_FUNC_1 &pcfg_pull_default>,
 							<RK_GPIO3 13 RK_FUNC_1 &pcfg_pull_default>;
-					rockchip,config = <&pcfg_pull_default>;
 				};
 			};
 
 			sd1 {
 				sd1_clk: sd1-clk {
 					rockchip,pins = <RK_GPIO3 21 RK_FUNC_1 &pcfg_pull_default>;
-					rockchip,config = <&pcfg_pull_default>;
 				};
 
 				sd1_cmd: sd1-cmd {
 					rockchip,pins = <RK_GPIO3 16 RK_FUNC_1 &pcfg_pull_default>;
-					rockchip,config = <&pcfg_pull_default>;
 				};
 
 				sd1_cd: sd1-cd {
 					rockchip,pins = <RK_GPIO3 22 RK_FUNC_1 &pcfg_pull_default>;
-					rockchip,config = <&pcfg_pull_default>;
 				};
 
 				sd1_wp: sd1-wp {
 					rockchip,pins = <RK_GPIO3 23 RK_FUNC_1 &pcfg_pull_default>;
-					rockchip,config = <&pcfg_pull_default>;
 				};
 
 				sd1_bus1: sd1-bus-width1 {
 					rockchip,pins = <RK_GPIO3 17 RK_FUNC_1 &pcfg_pull_default>;
-					rockchip,config = <&pcfg_pull_default>;
 				};
 
 				sd1_bus4: sd1-bus-width4 {
@@ -338,7 +317,6 @@
 							<RK_GPIO3 18 RK_FUNC_1 &pcfg_pull_default>,
 							<RK_GPIO3 19 RK_FUNC_1 &pcfg_pull_default>,
 							<RK_GPIO3 20 RK_FUNC_1 &pcfg_pull_default>;
-					rockchip,config = <&pcfg_pull_default>;
 				};
 			};
 		};
-- 
1.7.10.4
