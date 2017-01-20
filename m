From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 20 Jan 2017 08:44:36 -0700
Subject: [PATCH] ARM: dts: at91: Enable DMA on sama5d2_xplained console
In-Reply-To: <20170119220539.19011-1-alexandre.belloni@free-electrons.com>
References: <20170119220539.19011-1-alexandre.belloni@free-electrons.com>
Message-ID: <116feb3d-01d5-964b-385e-688e29968ab6@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 19/01/2017 ? 15:05, Alexandre Belloni a ?crit :
> Enable DMA on uart1 to get a more reliable console.
> 
> Cc: stable <stable@vger.kernel.org> #v4.3+
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> index 0b9a59d5fdac..30fac04289a5 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> @@ -148,6 +148,8 @@
>  			uart1: serial at f8020000 {
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&pinctrl_uart1_default>;
> +				atmel,use-dma-rx;
> +				atmel,use-dma-tx;
>  				status = "okay";
>  			};
>  
> 


-- 
Nicolas Ferre
