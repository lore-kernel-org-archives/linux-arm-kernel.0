From: nicolas.ferre@microchip.com (Nicolas Ferre)
Date: Mon, 27 Mar 2017 17:22:00 +0200
Subject: [PATCH] MAINTAINERS: Add memory drivers to AT91 entry
In-Reply-To: <20170327152101.21977-1-alexandre.belloni@free-electrons.com>
References: <20170327152101.21977-1-alexandre.belloni@free-electrons.com>
Message-ID: <030be639-2114-7588-5671-b3ec4377dfa3@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 27/03/2017 ? 17:21, Alexandre Belloni a ?crit :
> Both atmel-ebi and atmel-sdram are maintained as part of the Atmel ARM
> SoCs.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c45c02bc6082..6531d239db6b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1111,6 +1111,7 @@ F:	arch/arm/boot/dts/at91*.dtsi
>  F:	arch/arm/boot/dts/sama*.dts
>  F:	arch/arm/boot/dts/sama*.dtsi
>  F:	arch/arm/include/debug/at91.S
> +F:	drivers/memory/atmel*
>  
>  ARM/ATMEL AT91 Clock Support
>  M:	Boris Brezillon <boris.brezillon@free-electrons.com>
> 


-- 
Nicolas Ferre
