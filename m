From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 11 Sep 2012 12:34:27 +0200
Subject: [PATCH 09/14] arm: at91: dt: sam9m10g45ek: use rts/cts pinctrl
 group for uart1
In-Reply-To: <1344603731-32667-9-git-send-email-plagnioj@jcrosoft.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
 <1344603731-32667-9-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <504F13B3.3050802@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2012 03:02 PM, Jean-Christophe PLAGNIOL-VILLARD :
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
>  arch/arm/boot/dts/at91sam9m10g45ek.dts |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
> index a3633bd..16a13cd 100644
> --- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
> +++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
> @@ -39,6 +39,7 @@
>  			};
>  
>  			usart1: serial at fff90000 {
> +				pinctrl-0 = <&pinctrl_uart0 &pinctrl_uart1_rts_cts>;
>  				status = "okay";
>  			};


Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

-- 
Nicolas Ferre
