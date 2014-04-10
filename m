From: matt.porter@linaro.org (Matt Porter)
Date: Thu, 10 Apr 2014 13:56:23 -0400
Subject: [PATCH v3 2/3] Update bcm_defconfig with new pinctrl CONFIG
In-Reply-To: <1396478439-16586-3-git-send-email-syin@broadcom.com>
References: <1390509887-19278-1-git-send-email-syin@broadcom.com>
 <1396478439-16586-1-git-send-email-syin@broadcom.com>
 <1396478439-16586-3-git-send-email-syin@broadcom.com>
Message-ID: <20140410175623.GC23695@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 02, 2014 at 03:40:38PM -0700, Sherman Yin wrote:
> To be consistent with other Broadcom drivers, the Broadcom Capri pinctrl
> driver and its related CONFIG option are renamed to bcm281xx.
> 
> This commit updates the defconfig that enables the pinctrl driver.
> 
> Signed-off-by: Sherman Yin <syin@broadcom.com>
> Reviewed-by: Matt Porter <mporter@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Matt Porter <mporter@linaro.org>

> ---
>  arch/arm/configs/bcm_defconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
> index 2519d6d..b4d3013 100644
> --- a/arch/arm/configs/bcm_defconfig
> +++ b/arch/arm/configs/bcm_defconfig
> @@ -125,7 +125,7 @@ CONFIG_CRC_ITU_T=y
>  CONFIG_CRC7=y
>  CONFIG_XZ_DEC=y
>  CONFIG_AVERAGE=y
> -CONFIG_PINCTRL_CAPRI=y
> +CONFIG_PINCTRL_BCM281XX=y
>  CONFIG_WATCHDOG=y
>  CONFIG_BCM_KONA_WDT=y
>  CONFIG_BCM_KONA_WDT_DEBUG=y
> -- 
> 1.7.9.5
> 
