From: charu@ti.com (Varadarajan, Charulatha)
Date: Tue, 9 Nov 2010 10:32:51 +0530
Subject: [PATCH v4 07/13] OMAP4: DMA: hwmod: add system DMA
In-Reply-To: <1289225272-9767-8-git-send-email-manjugk@ti.com>
References: <1289225272-9767-1-git-send-email-manjugk@ti.com>
	<1289225272-9767-8-git-send-email-manjugk@ti.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB030D4FA77A@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


One minor comment,
 
<<snip>>

> +
>  static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
>  	/* dmm class */
>  	&omap44xx_dmm_hwmod,
> @@ -1077,6 +1174,8 @@ static __initdata struct omap_hwmod 
> *omap44xx_hwmods[] = {
>  	&omap44xx_uart2_hwmod,
>  	&omap44xx_uart3_hwmod,
>  	&omap44xx_uart4_hwmod,
> +	/* dma class */
> +	&omap44xx_dma_system_hwmod,

Add a blank line between each class. See [1]
Same is applicable to patches 4, 5 and 6

[1] https://patchwork.kernel.org/patch/305062/
