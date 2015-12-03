From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 3 Dec 2015 11:33:24 +0100
Subject: [PATCH v2 3/4] ARM: at91/dt: sama5d4: update i2c compatible string
In-Reply-To: <1449136434-27619-5-git-send-email-ludovic.desroches@atmel.com>
References: <1449136434-27619-1-git-send-email-ludovic.desroches@atmel.com>
 <1449136434-27619-5-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <56601A74.3040507@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 03/12/2015 10:53, Ludovic Desroches a ?crit :
> A new compatible string has been introduced: atmel,sama5d4-i2c. It
> allows to use the i2c-sda-hold-time-ns property if needed.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Wolfram, we'll take this one with us in the at91 branches that will go
into arm-soc. It'll be queued in at91-4.5-dt branch soon.

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


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
