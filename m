From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Thu, 9 Jul 2015 19:57:04 +0000
Subject: [PATCH 3/3] ARM: ep93xx: add framebuffer to the defconfig
In-Reply-To: <1436456606-4963-1-git-send-email-linus.walleij@linaro.org>
References: <1436456606-4963-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <DC148C5AA1CEBA4E87973D432B1C2D883D4D95BD@P3PWEX4MB008.ex4.secureserver.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 09, 2015 8:43 AM, Linus Walleij wrote:
> The EP93xx SoC has a framebuffer driver, let's add this to the
> defconfig so we can have graphics working out of the box.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/configs/ep93xx_defconfig | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/configs/ep93xx_defconfig b/arch/arm/configs/ep93xx_defconfig
> index e684386e97ba..a7846d64b396 100644
> --- a/arch/arm/configs/ep93xx_defconfig
> +++ b/arch/arm/configs/ep93xx_defconfig
> @@ -90,6 +90,10 @@ CONFIG_SPI=y
>  CONFIG_SPI_EP93XX=y
>  CONFIG_WATCHDOG=y
>  CONFIG_EP93XX_WATCHDOG=y
> +CONFIG_FB=y
> +CONFIG_FB_MODE_HELPERS=y
> +CONFIG_FB_EP93XX=y
> +CONFIG_LOGO=y
>  CONFIG_USB=y
>  CONFIG_USB_DYNAMIC_MINORS=y
>  CONFIG_USB_OHCI_HCD=y

Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>
