From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 7 Feb 2014 16:47:20 +0100
Subject: [PATCH] at91: dt: sam9263: fixed compatibility string for the I2C
In-Reply-To: <1389781486-29670-1-git-send-email-jjhiblot@traphandler.com>
References: <1389781486-29670-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <52F50008.3050001@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/01/2014 11:24, Jean-Jacques Hiblot :
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Added to at91-3.14-fixes

Thanks, bye,

> ---
>  arch/arm/boot/dts/at91sam9263.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
> index c8fa9b9..7d6dd09 100644
> --- a/arch/arm/boot/dts/at91sam9263.dtsi
> +++ b/arch/arm/boot/dts/at91sam9263.dtsi
> @@ -523,7 +523,7 @@
>  			};
>  
>  			i2c0: i2c at fff88000 {
> -				compatible = "atmel,at91sam9263-i2c";
> +				compatible = "atmel,at91sam9260-i2c";
>  				reg = <0xfff88000 0x100>;
>  				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 6>;
>  				#address-cells = <1>;
> 


-- 
Nicolas Ferre
