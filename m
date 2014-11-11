From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 11 Nov 2014 22:19:12 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: enable DS1307 rtc and gpio fan
 by default
In-Reply-To: <1415131893-3363-1-git-send-email-smoch@web.de>
References: <20141103031609.GA10821@tiger>
 <1415131893-3363-1-git-send-email-smoch@web.de>
Message-ID: <20141111141909.GD2704@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 04, 2014 at 09:11:33PM +0100, Soeren Moch wrote:
> Used on TBS2910 board.
> 
> Signed-off-by: Soeren Moch <smoch@web.de>

Applied, thanks.

> --
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> ---
>  arch/arm/configs/imx_v6_v7_defconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 16cfec4..39e4fe2 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -165,7 +165,7 @@ CONFIG_SPI_IMX=y
>  CONFIG_GPIO_SYSFS=y
>  CONFIG_GPIO_MC9S08DZ60=y
>  CONFIG_GPIO_STMPE=y
> -# CONFIG_HWMON is not set
> +CONFIG_SENSORS_GPIO_FAN=y
>  CONFIG_WATCHDOG=y
>  CONFIG_IMX2_WDT=y
>  CONFIG_MFD_DA9052_I2C=y
> @@ -240,6 +240,7 @@ CONFIG_LEDS_TRIGGER_BACKLIGHT=y
>  CONFIG_LEDS_TRIGGER_GPIO=y
>  CONFIG_RTC_CLASS=y
>  CONFIG_RTC_INTF_DEV_UIE_EMUL=y
> +CONFIG_RTC_DRV_DS1307=y
>  CONFIG_RTC_DRV_PCF8563=y
>  CONFIG_RTC_DRV_MC13XXX=y
>  CONFIG_RTC_DRV_MXC=y
> -- 
> 1.9.1
> 
