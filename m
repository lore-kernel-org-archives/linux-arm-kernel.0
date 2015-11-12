From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 12 Nov 2015 15:07:45 +0100
Subject: [PATCH v2 4/5] arm: dts: remove dm816x invalid DT l3_main hwmod
Message-ID: <56449D31.7010801@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove invalid l3_main hwmod entry from dm816x DT ocp node.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/dm816x.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.dtsi
index 51ad4a9..b9feeea 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -64,7 +64,6 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
-		ti,hwmods = "l3_main";

 		prcm: prcm at 48180000 {
 			compatible = "ti,dm816-prcm";
-- 
1.9.1
