From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 2 Dec 2015 12:07:08 +0100
Subject: [PATCH 3/4] ARM: at91/dt: sama5d4: update i2c compatible string
In-Reply-To: <1449052747-20991-3-git-send-email-ludovic.desroches@atmel.com>
References: <1449052747-20991-1-git-send-email-ludovic.desroches@atmel.com>
 <1449052747-20991-3-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <565ED0DC.9010907@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 02/12/2015 11:39, Ludovic Desroches a ?crit :
> A new compatible string has been introduced: atmel,sama5d4-i2c. It
> allows to use the i2c-sda-hold-time-ns property if needed.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Ok, we'll need to synchronize with Wolfram for the 2 remaining ones of
this series.


> ---
>  arch/arm/boot/dts/sama5d4.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index 2193637..83d7e7c 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -916,7 +916,7 @@
>  			};
>  
>  			i2c0: i2c at f8014000 {
> -				compatible = "atmel,at91sam9x5-i2c";
> +				compatible = "atmel,sama5d4-i2c";
>  				reg = <0xf8014000 0x4000>;
>  				interrupts = <32 IRQ_TYPE_LEVEL_HIGH 6>;
>  				dmas = <&dma1
> @@ -935,7 +935,7 @@
>  			};
>  
>  			i2c1: i2c at f8018000 {
> -				compatible = "atmel,at91sam9x5-i2c";
> +				compatible = "atmel,sama5d4-i2c";
>  				reg = <0xf8018000 0x4000>;
>  				interrupts = <33 IRQ_TYPE_LEVEL_HIGH 6>;
>  				dmas = <&dma1
> @@ -975,7 +975,7 @@
>  			};
>  
>  			i2c2: i2c at f8024000 {
> -				compatible = "atmel,at91sam9x5-i2c";
> +				compatible = "atmel,sama5d4-i2c";
>  				reg = <0xf8024000 0x4000>;
>  				interrupts = <34 IRQ_TYPE_LEVEL_HIGH 6>;
>  				dmas = <&dma1
> 


-- 
Nicolas Ferre
