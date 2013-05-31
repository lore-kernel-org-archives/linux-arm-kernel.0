From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 31 May 2013 15:58:37 +0200
Subject: [PATCH 2/2] ARM: shmobile: sdhi: remove DMA hardware dependencies
In-Reply-To: <1370008605-3745603-2-git-send-email-arnd@arndb.de>
References: <1370008605-3745603-1-git-send-email-arnd@arndb.de>
 <1370008605-3745603-2-git-send-email-arnd@arndb.de>
Message-ID: <2364919.FdR1Nu0Y37@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 31 May 2013 15:56:45 Arnd Bergmann wrote:
> --- a/include/linux/mmc/sh_mobile_sdhi.h
> +++ b/include/linux/mmc/sh_mobile_sdhi.h
> @@ -2,6 +2,7 @@
>  #define LINUX_MMC_SH_MOBILE_SDHI_H
>  
>  #include <linux/types.h>
> +#include <linux/dmaengine.h>
>  
>  struct platform_device;
>  

This hunk should have been in the first patch. I'll
wait for comments before re-sending. Don't apply as-is.

	Arnd
