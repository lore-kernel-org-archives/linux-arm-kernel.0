From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 5 Mar 2013 12:05:20 +0100
Subject: [PATCH] ARM: imx_v4_v5_defconfig: Add CONFIG_GPIO_SYSFS
In-Reply-To: <1361202320-25917-1-git-send-email-fabio.estevam@freescale.com>
References: <1361202320-25917-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130305110520.GX1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 18, 2013 at 12:45:20PM -0300, Fabio Estevam wrote:
> Add CONFIG_GPIO_SYSFS as it is helpful for accessing GPIO from userspace.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks

Sascha

> ---
>  arch/arm/configs/imx_v4_v5_defconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
> index 02c657a..f07a847 100644
> --- a/arch/arm/configs/imx_v4_v5_defconfig
> +++ b/arch/arm/configs/imx_v4_v5_defconfig
> @@ -109,6 +109,7 @@ CONFIG_I2C_IMX=y
>  CONFIG_SPI=y
>  CONFIG_SPI_IMX=y
>  CONFIG_SPI_SPIDEV=y
> +CONFIG_GPIO_SYSFS=y
>  CONFIG_W1=y
>  CONFIG_W1_MASTER_MXC=y
>  CONFIG_W1_SLAVE_THERM=y
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
