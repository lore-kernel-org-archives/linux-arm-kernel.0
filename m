From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Thu, 9 Jul 2015 19:57:01 +0000
Subject: [PATCH 2/3] ARM: ep93xx: add DMA engine to the defconfig
In-Reply-To: <1436456595-4915-1-git-send-email-linus.walleij@linaro.org>
References: <1436456595-4915-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <DC148C5AA1CEBA4E87973D432B1C2D883D4D95B6@P3PWEX4MB008.ex4.secureserver.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 09, 2015 8:43 AM, Linus Walleij wrote:
> Several boards can make use of the DMA engine on the EP93xx
> so let's enable this by default in the defconfig.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/configs/ep93xx_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/configs/ep93xx_defconfig b/arch/arm/configs/ep93xx_defconfig
> index 2ca11ce504c7..e684386e97ba 100644
> --- a/arch/arm/configs/ep93xx_defconfig
> +++ b/arch/arm/configs/ep93xx_defconfig
> @@ -109,6 +109,8 @@ CONFIG_RTC_CLASS=y
>  CONFIG_RTC_DRV_DS1307=y
>  CONFIG_RTC_DRV_M48T86=y
>  CONFIG_RTC_DRV_EP93XX=y
> +CONFIG_DMADEVICES=y
> +CONFIG_EP93XX_DMA=y
>  CONFIG_EXT2_FS=y
>  CONFIG_EXT3_FS=y
>  # CONFIG_EXT3_FS_XATTR is not set

Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>
