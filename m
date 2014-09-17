From: davidcdueck@googlemail.com (David Dueck)
Date: Wed, 17 Sep 2014 10:33:32 +0200
Subject: [PATCH] ARM: at91/dt: Fix typo regarding can0_clk
Message-ID: <1410942812-31682-1-git-send-email-davidcdueck@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise the clock for can0 will never get enabled.

Signed-off-by: David Dueck <davidcdueck@googlemail.com>
Signed-off-by: Anthony Harivel <anthony.harivel@emtrion.de>
---
 arch/arm/boot/dts/sama5d3_can.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d3_can.dtsi b/arch/arm/boot/dts/sama5d3_can.dtsi
index a077585..eaf4145 100644
--- a/arch/arm/boot/dts/sama5d3_can.dtsi
+++ b/arch/arm/boot/dts/sama5d3_can.dtsi
@@ -40,7 +40,7 @@
 						atmel,clk-output-range = <0 66000000>;
 					};
 
-					can1_clk: can0_clk {
+					can1_clk: can1_clk {
 						#clock-cells = <0>;
 						reg = <41>;
 						atmel,clk-output-range = <0 66000000>;
-- 
2.1.0
