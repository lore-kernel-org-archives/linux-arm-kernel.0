From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 18 Jul 2014 15:46:34 +0200
Subject: [PATCH] ARM: at91/dt: add missing clocks property to pwm node
 in sam9x5.dtsi
In-Reply-To: <1405623838-22496-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1405623838-22496-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <53C9253A.8020404@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/07/2014 21:03, Boris BREZILLON :
> The pwm driver requires a clocks property referencing the pwm peripheral
> clk.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>


Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


> ---
>  arch/arm/boot/dts/at91sam9x5.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index 2ebc421..6902f53 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -1124,6 +1124,7 @@
>  				compatible = "atmel,at91sam9rl-pwm";
>  				reg = <0xf8034000 0x300>;
>  				interrupts = <18 IRQ_TYPE_LEVEL_HIGH 4>;
> +				clocks = <&pwm_clk>;
>  				#pwm-cells = <3>;
>  				status = "disabled";
>  			};
> 


-- 
Nicolas Ferre
