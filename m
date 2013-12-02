From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 2 Dec 2013 09:39:29 +0100
Subject: [PATCH 1/2] ARM: at91: at91sam9g45: set default mmc pinctrl-names
In-Reply-To: <1385128193-9963-1-git-send-email-ludovic.desroches@atmel.com>
References: <1385128193-9963-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <529C4741.7030308@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/11/2013 14:49, ludovic.desroches at atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> pinctrl-names property was missing from mmc nodes.
>
> Cc: <stable@vger.kernel.org> #3.11+
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

and queued in at91-3.14-dt.

Thanks, bye,

> ---
>   arch/arm/boot/dts/at91sam9g45.dtsi |    2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> index c3e5148..cf7de80 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -618,6 +618,7 @@
>   				compatible = "atmel,hsmci";
>   				reg = <0xfff80000 0x600>;
>   				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 0>;
> +				pinctrl-names = "default";
>   				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(0)>;
>   				dma-names = "rxtx";
>   				#address-cells = <1>;
> @@ -629,6 +630,7 @@
>   				compatible = "atmel,hsmci";
>   				reg = <0xfffd0000 0x600>;
>   				interrupts = <29 IRQ_TYPE_LEVEL_HIGH 0>;
> +				pinctrl-names = "default";
>   				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(13)>;
>   				dma-names = "rxtx";
>   				#address-cells = <1>;
>


-- 
Nicolas Ferre
