From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 17 Sep 2012 17:27:09 +0200
Subject: [PATCH 12/16] arm: at91: dt: sam9263ek: use rts/cts pinctrl group for
 uart0
In-Reply-To: <1347895633-1763-1-git-send-email-plagnioj@jcrosoft.com>
References: <20120917140423.GA17667@game.jcrosoft.org>
 <1347895633-1763-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1347895633-1763-12-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/boot/dts/at91sam9263ek.dts |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index f86ac4b..7cfe9d5 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -38,6 +38,7 @@
 			};
 
 			usart0: serial at fff8c000 {
+				pinctrl-0 = <&pinctrl_uart0 &pinctrl_uart0_rts_cts>;
 				status = "okay";
 			};
 
-- 
1.7.10.4
