From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 22 Nov 2013 19:33:02 +0100
Subject: [PATCH 1/2] ARM: at91: at91sam9g45: set default mmc pinctrl-names
In-Reply-To: <1385128193-9963-1-git-send-email-ludovic.desroches@atmel.com>
References: <1385128193-9963-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <20131122183302.GN14627@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:49 Fri 22 Nov     , ludovic.desroches at atmel.com wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> pinctrl-names property was missing from mmc nodes.
> 
> Cc: <stable@vger.kernel.org> #3.11+
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
on both Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> ---
>  arch/arm/boot/dts/at91sam9g45.dtsi |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> index c3e5148..cf7de80 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -618,6 +618,7 @@
>  				compatible = "atmel,hsmci";
>  				reg = <0xfff80000 0x600>;
>  				interrupts = <11 IRQ_TYPE_LEVEL_HIGH 0>;
> +				pinctrl-names = "default";
>  				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(0)>;
>  				dma-names = "rxtx";
>  				#address-cells = <1>;
> @@ -629,6 +630,7 @@
>  				compatible = "atmel,hsmci";
>  				reg = <0xfffd0000 0x600>;
>  				interrupts = <29 IRQ_TYPE_LEVEL_HIGH 0>;
> +				pinctrl-names = "default";
>  				dmas = <&dma 1 AT91_DMA_CFG_PER_ID(13)>;
>  				dma-names = "rxtx";
>  				#address-cells = <1>;
> -- 
> 1.7.9.5
> 
