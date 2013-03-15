From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 15 Mar 2013 17:07:18 +0100
Subject: [PATCH] MAINTAINERS: add maintainer entry for atmel i2c driver
In-Reply-To: <1363361577-7770-1-git-send-email-ludovic.desroches@atmel.com>
References: <1363361577-7770-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <51434736.5020004@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/15/2013 04:32 PM, ludovic.desroches at atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Create an entry for atmel i2c driver: i2c-at91.c
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
> Hello,
> 
> If there are no objections, I'll take the maintenance of the at91 i2c driver
> since there is no maintainer.

Sure, no objection ;-)
Good luck!

> Wolfram, can you take this patch or do I have to ask someone else?
> 
> Regards
> 
> Ludovic
> 
> 
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9561658..d667ecc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1467,6 +1467,12 @@ F:	drivers/dma/at_hdmac.c
>  F:	drivers/dma/at_hdmac_regs.h
>  F:	include/linux/platform_data/dma-atmel.h
>  
> +ATMEL I2C DRIVER
> +M:	Ludovic Desroches <ludovic.desroches@atmel.com>
> +L:	linux-i2c at vger.kernel.org
> +S:	Supported
> +F:	drivers/i2c/busses/i2c-at91.c
> +
>  ATMEL ISI DRIVER
>  M:	Josh Wu <josh.wu@atmel.com>
>  L:	linux-media at vger.kernel.org
> 


-- 
Nicolas Ferre
