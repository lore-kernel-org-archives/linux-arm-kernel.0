From: poeschel@lemonage.de (Lars Poeschel)
Date: Thu,  5 Oct 2017 09:33:57 +0200
Subject: [PATCH] ARM: dts: omap3: Replace deprecated mcp prefix
Message-ID: <20171005073357.9427-1-poeschel@lemonage.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The devicetree prefix mcp is deprecated in favour of microchip. Thus
this replaces mcp with microchip for the mcp23017 gpio expander chip.

Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index fa611a5e4850..343a36d8031d 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -257,7 +257,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c3_pins>;
 		gpiom1: gpio at 20 {
-			compatible = "mcp,mcp23017";
+			compatible = "microchip,mcp23017";
 			gpio-controller;
 			#gpio-cells = <2>;
 			reg = <0x20>;
-- 
2.14.2
