From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 8 Oct 2012 11:28:38 +0200
Subject: [PATCH v2] ARM: imx_v6_v7_defconfig: Enable CONFIG_GPIO_MC9S08DZ60
In-Reply-To: <1347647145-23798-1-git-send-email-fabio.estevam@freescale.com>
References: <1347647145-23798-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20121008092838.GM1322@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2012 at 03:25:45PM -0300, Fabio Estevam wrote:
> On mx35pdk board there is an 8-bit microcontroller that controls several IOs, such
> as backlight enable pin, USB host VBUS, etc.
> 
> Let it build by default.
> 
> mx35pdk also needs CONFIG_LCD_PLATFORM to be selected to activate the display,
> so also make this the default.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks

Sascha

> ---
> Changes since v1:
> - Also select CONFIG_LCD_PLATFORM
>  arch/arm/configs/imx_v6_v7_defconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 565132d..8cfd747 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -140,6 +140,7 @@ CONFIG_I2C_IMX=y
>  CONFIG_SPI=y
>  CONFIG_SPI_IMX=y
>  CONFIG_GPIO_SYSFS=y
> +CONFIG_GPIO_MC9S08DZ60=y
>  # CONFIG_HWMON is not set
>  CONFIG_WATCHDOG=y
>  CONFIG_IMX2_WDT=y
> @@ -156,6 +157,7 @@ CONFIG_SOC_CAMERA=y
>  CONFIG_SOC_CAMERA_OV2640=y
>  CONFIG_VIDEO_MX3=y
>  CONFIG_FB=y
> +CONFIG_LCD_PLATFORM=y
>  CONFIG_BACKLIGHT_LCD_SUPPORT=y
>  CONFIG_LCD_CLASS_DEVICE=y
>  CONFIG_LCD_L4F00242T03=y
> -- 
> 1.7.9.5
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
