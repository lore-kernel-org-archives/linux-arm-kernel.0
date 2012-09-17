From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 17 Sep 2012 17:27:08 +0200
Subject: [PATCH 11/16] arm: at91: dt: sam9m10g45ek: use rts/cts pinctrl group
 for uart1
In-Reply-To: <1347895633-1763-1-git-send-email-plagnioj@jcrosoft.com>
References: <20120917140423.GA17667@game.jcrosoft.org>
 <1347895633-1763-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1347895633-1763-11-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/boot/dts/at91sam9m10g45ek.dts |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index a3633bd..16a13cd 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -39,6 +39,7 @@
 			};
 
 			usart1: serial at fff90000 {
+				pinctrl-0 = <&pinctrl_uart0 &pinctrl_uart1_rts_cts>;
 				status = "okay";
 			};
 
-- 
1.7.10.4
