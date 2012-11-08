From: jg1.han@samsung.com (Jingoo Han)
Date: Thu, 08 Nov 2012 10:33:42 +0900
Subject: [PATCH] ARM: SAMSUNG: Fix typo in definition of
 VIDCON1_VSTATUS_FRONTPORCH value
In-Reply-To: <1429686.vBaRDnu5Be@amdc1227>
References: <1429686.vBaRDnu5Be@amdc1227>
Message-ID: <000001cdbd51$160995e0$421cc1a0$%han@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 07, 2012 9:31 PM Jingoo Han wrote
> 
> The correct value for VIDCON1_VSTATUS_FRONTPORCH is 3, not 0.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

According to the datasheet, 3 is right value.

Acked-by: Jingoo Han <jg1.han@samsung.com>

> ---
>  include/video/samsung_fimd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/video/samsung_fimd.h b/include/video/samsung_fimd.h
> index 7ae6c07..263ed4b 100644
> --- a/include/video/samsung_fimd.h
> +++ b/include/video/samsung_fimd.h
> @@ -82,7 +82,7 @@
>  #define VIDCON1_VSTATUS_VSYNC			(0x0 << 13)
>  #define VIDCON1_VSTATUS_BACKPORCH		(0x1 << 13)
>  #define VIDCON1_VSTATUS_ACTIVE			(0x2 << 13)
> -#define VIDCON1_VSTATUS_FRONTPORCH		(0x0 << 13)
> +#define VIDCON1_VSTATUS_FRONTPORCH		(0x3 << 13)
>  #define VIDCON1_VCLK_MASK			(0x3 << 9)
>  #define VIDCON1_VCLK_HOLD			(0x0 << 9)
>  #define VIDCON1_VCLK_RUN			(0x1 << 9)
> --
> 1.8.0
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
