From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Tue, 13 Oct 2015 13:24:24 +0200
Subject: [PATCH] ARM: at91/dt: fix "disabled" property on at91rm9200
Message-ID: <1444735464-5447-1-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix instances of "disable" instead of "disabled"
in the at91rm9200 dtsi.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index 60edd8baebb8..6587cd59a586 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -426,7 +426,7 @@
 				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
 				clocks = <&ssc0_clk>;
 				clock-names = "pclk";
-				status = "disable";
+				status = "disabled";
 			};
 
 			ssc1: ssc at fffd4000 {
@@ -437,7 +437,7 @@
 				pinctrl-0 = <&pinctrl_ssc1_tx &pinctrl_ssc1_rx>;
 				clocks = <&ssc1_clk>;
 				clock-names = "pclk";
-				status = "disable";
+				status = "disabled";
 			};
 
 			ssc2: ssc at fffd8000 {
@@ -448,7 +448,7 @@
 				pinctrl-0 = <&pinctrl_ssc2_tx &pinctrl_ssc2_rx>;
 				clocks = <&ssc2_clk>;
 				clock-names = "pclk";
-				status = "disable";
+				status = "disabled";
 			};
 
 			macb0: ethernet at fffbc000 {
-- 
2.1.4
