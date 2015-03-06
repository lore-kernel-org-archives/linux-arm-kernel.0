From: tony@atomide.com (Tony Lindgren)
Date: Fri, 6 Mar 2015 09:49:34 -0800
Subject: [PATCH] ARM: OMAP: enable TWL4030_USB in omap2plus_defconfig
In-Reply-To: <1424984849-13083-1-git-send-email-aaro.koskinen@iki.fi>
References: <1424984849-13083-1-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20150306174933.GX13520@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [150226 13:11]:
> Enable TWL4030_USB which is used at least on Nokia N900/N950/N9 (OMAP3).
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  arch/arm/configs/omap2plus_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index b738652..8c93aa9 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -375,6 +375,7 @@ CONFIG_PWM_TWL=m
>  CONFIG_PWM_TWL_LED=m
>  CONFIG_OMAP_USB2=m
>  CONFIG_TI_PIPE3=m
> +CONFIG_TWL4030_USB=m
>  CONFIG_EXT2_FS=y
>  CONFIG_EXT3_FS=y
>  # CONFIG_EXT3_FS_XATTR is not set

Thanks I noticed the same on beagle-xm too, applying into
omap-for-v4.0/fixes.

Tony
