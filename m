From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Thu, 9 Jul 2015 19:56:56 +0000
Subject: [PATCH 1/3] ARM: ep93xx: add GPIO I2C to defconfig
In-Reply-To: <1436456573-4860-1-git-send-email-linus.walleij@linaro.org>
References: <1436456573-4860-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <DC148C5AA1CEBA4E87973D432B1C2D883D4D95AF@P3PWEX4MB008.ex4.secureserver.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 09, 2015 8:43 AM, Linus Walleij wrote:
> Some of the EP93xx boards have I2C devices on bit-banged GPIO
> I2C, so add this to the defconfig.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/configs/ep93xx_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/configs/ep93xx_defconfig b/arch/arm/configs/ep93xx_defconfig
> index 9a5205abc7c3..2ca11ce504c7 100644
> --- a/arch/arm/configs/ep93xx_defconfig
> +++ b/arch/arm/configs/ep93xx_defconfig
> @@ -82,6 +82,7 @@ CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
>  # CONFIG_HW_RANDOM is not set
>  CONFIG_I2C=y
>  CONFIG_I2C_CHARDEV=y
> +CONFIG_I2C_GPIO=y
>  CONFIG_I2C_DEBUG_CORE=y
>  CONFIG_I2C_DEBUG_ALGO=y
>  CONFIG_I2C_DEBUG_BUS=y

Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>
