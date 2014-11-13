From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 13 Nov 2014 11:27:00 +0100
Subject: [PATCH] ARM: dts: sama5d4: use macro instead of numeric value
In-Reply-To: <1415870947-23120-1-git-send-email-ludovic.desroches@atmel.com>
References: <1415870947-23120-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <54648774.6080006@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/11/2014 10:29, Ludovic Desroches :
> There is a macro for the irq type.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

queued in at91-3.18-fixes (but low priority though: don't know if it'll
make it for 3.18).

Bye,

> ---
>  arch/arm/boot/dts/sama5d4.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index e0157b0..338dfd8 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -817,7 +817,7 @@
>  			i2c2: i2c at f8024000 {
>  				compatible = "atmel,at91sam9x5-i2c";
>  				reg = <0xf8024000 0x4000>;
> -				interrupts = <34 4 6>;
> +				interrupts = <34 IRQ_TYPE_LEVEL_HIGH 6>;
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&pinctrl_i2c2>;
>  				#address-cells = <1>;
> 


-- 
Nicolas Ferre
