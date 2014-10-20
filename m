From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 20 Oct 2014 11:53:20 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: enable CONFIG_MMC_DW_ROCKCHIP
In-Reply-To: <1413789601-18350-1-git-send-email-olof@lixom.net>
References: <1413789601-18350-1-git-send-email-olof@lixom.net>
Message-ID: <2163732.sX0JlXCnoI@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 20. Oktober 2014, 00:20:01 schrieb Olof Johansson:
> Allows booting from SD/MMC on RK3288 and other platforms. Added here so I
> can enable the board in the boot farm.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

as it's already in arm-soc it's probably to late and the change is small 
enough to probably not even need it, but nevertheless

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig
> b/arch/arm/configs/multi_v7_defconfig index 491b7d5523bf..709ecc9009ec
> 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -353,6 +353,7 @@ CONFIG_MMC_MVSDIO=y
>  CONFIG_MMC_SUNXI=y
>  CONFIG_MMC_DW=y
>  CONFIG_MMC_DW_EXYNOS=y
> +CONFIG_MMC_DW_ROCKCHIP=y
>  CONFIG_NEW_LEDS=y
>  CONFIG_LEDS_CLASS=y
>  CONFIG_LEDS_GPIO=y
