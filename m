From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 20 May 2015 14:36:10 +0200
Subject: [PATCH] ARM: at91/dt: at91sam9x5: fix usart1 sck pin definition
Message-ID: <1432125370-21092-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SCK1 pin is pioC 29. Comment was okay.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 9c236c317eeb..dfdbdf43860e 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -505,7 +505,7 @@
 
 					pinctrl_usart1_sck: usart1_sck-0 {
 						atmel,pins =
-							<AT91_PIOC 28 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* PC29 periph C */
+							<AT91_PIOC 29 AT91_PERIPH_C AT91_PINCTRL_NONE>;	/* PC29 periph C */
 					};
 				};
 
-- 
2.1.3
