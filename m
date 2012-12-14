From: tony@atomide.com (Tony Lindgren)
Date: Fri, 14 Dec 2012 10:19:03 -0800
Subject: [PATCH -next] ARM: OMAP4: remove duplicated include from
 omap_hwmod_44xx_data.c
In-Reply-To: <CAPgLHd-WVCm8Ewndtu4THRW4gg+tOE6dBj9LDfRfA7MoKgXpBg@mail.gmail.com>
References: <CAPgLHd-WVCm8Ewndtu4THRW4gg+tOE6dBj9LDfRfA7MoKgXpBg@mail.gmail.com>
Message-ID: <20121214181902.GA4989@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Wei Yongjun <weiyj.lk@gmail.com> [121128 18:48]:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Remove duplicated include.

Thanks applying into omap-for-v3.8/fixes-for-merge-window.

Regards,

Tony
 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> ---
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index e5eda55..f13fdbb 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -26,7 +26,6 @@
>  
>  #include <plat-omap/dma-omap.h>
>  
> -#include <linux/platform_data/omap_ocp2scp.h>
>  #include <linux/platform_data/spi-omap2-mcspi.h>
>  #include <linux/platform_data/asoc-ti-mcbsp.h>
>  #include <plat/dmtimer.h>
> 
> 
