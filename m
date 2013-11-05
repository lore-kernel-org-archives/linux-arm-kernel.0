From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 5 Nov 2013 16:42:29 +0100
Subject: [PATCH] ARM: at91/trivial: fix at91rm9200 rts/cts pinctrl definitions
Message-ID: <1383666149-5837-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Swap names as they were improperly defined.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91rm9200.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91rm9200.dtsi
index f770655..c61b16f 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91rm9200.dtsi
@@ -191,12 +191,12 @@
 							 AT91_PIOA 18 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA18 periph A */
 					};
 
-					pinctrl_uart0_rts: uart0_rts-0 {
+					pinctrl_uart0_cts: uart0_cts-0 {
 						atmel,pins =
 							<AT91_PIOA 20 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA20 periph A */
 					};
 
-					pinctrl_uart0_cts: uart0_cts-0 {
+					pinctrl_uart0_rts: uart0_rts-0 {
 						atmel,pins =
 							<AT91_PIOA 21 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA21 periph A */
 					};
-- 
1.8.2.2
