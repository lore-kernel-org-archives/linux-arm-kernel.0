From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 16 Dec 2014 11:33:56 +0100
Subject: [PATCH] ARM: at91/dt: sama5d4: fix the timer reg length
In-Reply-To: <1418266473-30187-1-git-send-email-voice.shen@atmel.com>
References: <1418266473-30187-1-git-send-email-voice.shen@atmel.com>
Message-ID: <54900A94.1080001@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 11/12/2014 03:54, Bo Shen a ?crit :
> The second property of reg is the length, so correct it for timer.
> 
> Signed-off-by: Bo Shen <voice.shen@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

and stacked on top of at91-3.19-fixes.

Thanks.

> ---
> 
>  arch/arm/boot/dts/sama5d4.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
> index 2cc3cfe..0901706 100644
> --- a/arch/arm/boot/dts/sama5d4.dtsi
> +++ b/arch/arm/boot/dts/sama5d4.dtsi
> @@ -940,7 +940,7 @@
>  
>  			pit: timer at fc068630 {
>  				compatible = "atmel,at91sam9260-pit";
> -				reg = <0xfc068630 0xf>;
> +				reg = <0xfc068630 0x10>;
>  				interrupts = <3 IRQ_TYPE_LEVEL_HIGH 5>;
>  				clocks = <&h32ck>;
>  			};
> 


-- 
Nicolas Ferre
