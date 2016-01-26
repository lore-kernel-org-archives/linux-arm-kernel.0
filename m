From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 26 Jan 2016 14:34:01 +0100
Subject: [PATCH] ARM: dts: at91: sama5d4: fix instance id of DBGU
Message-ID: <1453815259-22299-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mohamed Jamsheeth Hajanajubudeen <mohamedjamsheeth.hajanajubudeen@atmel.com>

Change instance id of DBGU to 45.

Signed-off-by: Mohamed Jamsheeth Hajanajubudeen <mohamedjamsheeth.hajanajubudeen@atmel.com>
Fixes: 7c661394c56c ("ARM: at91: dt: add device tree file for SAMA5D4 SoC")
Cc: stable at vger.kernel.org   # 3.18+
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index b8032bca4621..db1151c18466 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1342,7 +1342,7 @@
 			dbgu: serial at fc069000 {
 				compatible = "atmel,at91sam9260-dbgu", "atmel,at91sam9260-usart";
 				reg = <0xfc069000 0x200>;
-				interrupts = <2 IRQ_TYPE_LEVEL_HIGH 7>;
+				interrupts = <45 IRQ_TYPE_LEVEL_HIGH 7>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_dbgu>;
 				clocks = <&dbgu_clk>;
-- 
2.1.3
