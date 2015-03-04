From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 4 Mar 2015 17:15:47 +0100
Subject: [PATCH 1/2] ARM: at91/dt: sama5d4: rename lcd_clk into lcdc_clk
Message-ID: <1425485748-16759-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris BREZILLON <boris.brezillon@free-electrons.com>

Rename lcd_clk into lcdc_clk to be consistent with sama5d3 clock
definitions.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 63eb7a2c08f7..a57b7965f98a 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -790,7 +790,7 @@
 						reg = <50>;
 					};
 
-					lcd_clk: lcd_clk {
+					lcdc_clk: lcdc_clk {
 						#clock-cells = <0>;
 						reg = <51>;
 					};
-- 
2.1.3
