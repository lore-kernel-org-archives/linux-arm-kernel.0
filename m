From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 29 Aug 2014 18:46:41 +0200
Subject: [PATCH] ARM: at91/dt: sam9x5: fix ADC compatible string
In-Reply-To: <1406038067-14697-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1406038067-14697-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <5400AE71.9040104@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/07/2014 16:07, Alexandre Belloni :
> Use the correct compatible string for the ADC of the at91sam9x5 family of SoCs.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Yep!

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  arch/arm/boot/dts/at91sam9x5.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index 2c0d6ea3ab41..5d7cf394f537 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -964,7 +964,7 @@
>  			adc0: adc at f804c000 {
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> -				compatible = "atmel,at91sam9260-adc";
> +				compatible = "atmel,at91sam9x5-adc";
>  				reg = <0xf804c000 0x100>;
>  				interrupts = <19 IRQ_TYPE_LEVEL_HIGH 0>;
>  				clocks = <&adc_clk>,
> 


-- 
Nicolas Ferre
