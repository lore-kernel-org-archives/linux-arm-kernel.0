From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Jun 2013 16:50:10 +0200
Subject: [PATCH 1/6] ARM: mx27: Replace clk_register_clkdev with clock DT
 lookup
In-Reply-To: <1371739815-6666-1-git-send-email-mpa@pengutronix.de>
References: <1371739815-6666-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1371739815-6666-2-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Similarly as it was done for mx6q, use a DT lookup in order to make maintainance
task for the clock devices easier.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
[Markus Pargmann: Add gpio clocks]
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx27.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 0695264..48c263c 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -208,6 +208,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				clocks = <&clks 47>;
+				clock-names = "ipg";
 			};
 
 			gpio2: gpio at 10015100 {
@@ -218,6 +220,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				clocks = <&clks 47>;
+				clock-names = "ipg";
 			};
 
 			gpio3: gpio at 10015200 {
@@ -228,6 +232,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				clocks = <&clks 47>;
+				clock-names = "ipg";
 			};
 
 			gpio4: gpio at 10015300 {
@@ -238,6 +244,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				clocks = <&clks 47>;
+				clock-names = "ipg";
 			};
 
 			gpio5: gpio at 10015400 {
@@ -248,6 +256,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				clocks = <&clks 47>;
+				clock-names = "ipg";
 			};
 
 			gpio6: gpio at 10015500 {
@@ -258,6 +268,8 @@
 				#gpio-cells = <2>;
 				interrupt-controller;
 				#interrupt-cells = <2>;
+				clocks = <&clks 47>;
+				clock-names = "ipg";
 			};
 
 			cspi3: cspi at 10017000 {
-- 
1.8.2.1
