From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 5 Sep 2014 17:21:28 +0200
Subject: [PATCH] ARM: at91/dt: sam9g20: set at91sam9g20 pllb driver
In-Reply-To: <1409606986-32455-1-git-send-email-gael.portay@gmail.com>
References: <1409606986-32455-1-git-send-email-gael.portay@gmail.com>
Message-ID: <5409D4F8.4090806@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/2014 23:29, Ga?l PORTAY :
> The at91sam9g20 SOC uses its own pllb implementation which is different
> from the one inherited from at91sam9260 SOC.
> 
> Signed-off-by: Ga?l PORTAY <gael.portay@gmail.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Stacked on at91-3.17-fixes. Thanks!

> ---
>  arch/arm/boot/dts/at91sam9g20.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91sam9g20.dtsi
> index 31f7652..4e0abbd 100644
> --- a/arch/arm/boot/dts/at91sam9g20.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g20.dtsi
> @@ -40,6 +40,7 @@
>  				};
>  
>  				pllb: pllbck {
> +					compatible = "atmel,at91sam9g20-clk-pllb";
>  					atmel,clk-input-range = <2000000 32000000>;
>  					atmel,pll-clk-output-ranges = <30000000 100000000 0 0>;
>  				};
> 


-- 
Nicolas Ferre
