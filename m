From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 11 Sep 2012 12:36:40 +0200
Subject: [PATCH 11/14] arm: at91: dt: sam9g20ek: use rts/cts/dtr/dsr/dcd/ri
 pinctrl group for uart0
In-Reply-To: <1344603731-32667-11-git-send-email-plagnioj@jcrosoft.com>
References: <20120810124820.GA20557@game.jcrosoft.org>
 <1344603731-32667-1-git-send-email-plagnioj@jcrosoft.com>
 <1344603731-32667-11-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <504F1438.9010202@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2012 03:02 PM, Jean-Christophe PLAGNIOL-VILLARD :
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
>  arch/arm/boot/dts/at91sam9g20ek_common.dtsi |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
> index b06c0db..e33ab0a 100644
> --- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
> @@ -35,6 +35,12 @@
>  			};
>  
>  			usart0: serial at fffb0000 {
> +				pinctrl-0 =
> +					<&pinctrl_uart0
> +					 &pinctrl_uart0_rts_cts
> +					 &pinctrl_uart0_dtr_dsr
> +					 &pinctrl_uart0_dcd
> +					 &pinctrl_uart0_ri>;
>  				status = "okay";
>  			};
>  
> 

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

-- 
Nicolas Ferre
