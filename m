From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 11 Sep 2012 12:34:47 +0200
Subject: [PATCH 10/14] arm: at91: dt: sam9263ek: use rts/cts pinctrl group
 for uart0
In-Reply-To: <1344603731-32667-10-git-send-email-plagnioj@jcrosoft.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
 <1344603731-32667-10-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <504F13C7.8040908@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2012 03:02 PM, Jean-Christophe PLAGNIOL-VILLARD :
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
>  arch/arm/boot/dts/at91sam9263ek.dts |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
> index f86ac4b..7cfe9d5 100644
> --- a/arch/arm/boot/dts/at91sam9263ek.dts
> +++ b/arch/arm/boot/dts/at91sam9263ek.dts
> @@ -38,6 +38,7 @@
>  			};
>  
>  			usart0: serial at fff8c000 {
> +				pinctrl-0 = <&pinctrl_uart0 &pinctrl_uart0_rts_cts>;
>  				status = "okay";
>  			};
>  

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

-- 
Nicolas Ferre
