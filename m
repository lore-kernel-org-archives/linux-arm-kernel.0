From: jiri.prchal@aksignal.cz (Jiri Prchal)
Date: Thu, 19 Sep 2013 14:28:39 +0200
Subject: [PATCH] at91: serial: fix wrong pinctrl_usart2_rts
Message-ID: <1379593719-9337-1-git-send-email-jiri.prchal@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace pinctrl_usart2_rts and pinctrl_usart2_cts istead of pinctrl_uart2_*.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
 arch/arm/boot/dts/at91sam9x5.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index c5d26b0..2d674d7 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -190,12 +190,12 @@
 							 AT91_PIOA 8 AT91_PERIPH_A AT91_PINCTRL_NONE>;	/* PA8 periph A */
 					};
 
-					pinctrl_uart2_rts: uart2_rts-0 {
+					pinctrl_usart2_rts: usart2_rts-0 {
 						atmel,pins =
 							<AT91_PIOB 0 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PB0 periph B */
 					};
 
-					pinctrl_uart2_cts: uart2_cts-0 {
+					pinctrl_usart2_cts: usart2_cts-0 {
 						atmel,pins =
 							<AT91_PIOB 1 AT91_PERIPH_B AT91_PINCTRL_NONE>;	/* PB1 periph B */
 					};
-- 
1.7.9.5
