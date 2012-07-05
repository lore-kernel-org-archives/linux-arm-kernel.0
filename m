From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 5 Jul 2012 20:55:27 +0200
Subject: [PATCH] ARM: imx: Kconfig: Remove IMX_HAVE_PLATFORM_IMX_SSI from
 MACH_MX25_3DS
In-Reply-To: <1341332536-2967-1-git-send-email-fabio.estevam@freescale.com>
References: <1341332536-2967-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120705185527.GX30009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2012 at 01:22:16PM -0300, Fabio Estevam wrote:
> commit 5fb86e5d4 (ARM: mx31_3ds: Add sound support) added audio support for
> mx31pdk, but touched MACH_MX25_3DS Kconfig by mistake.

Applied, thanks

Sascha

> 
> Remove IMX_HAVE_PLATFORM_IMX_SSI from MACH_MX25_3DS configuration.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-imx/Kconfig |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index eff4db5..0da882a 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -158,7 +158,6 @@ config MACH_MX25_3DS
>  	select IMX_HAVE_PLATFORM_IMX2_WDT
>  	select IMX_HAVE_PLATFORM_IMXDI_RTC
>  	select IMX_HAVE_PLATFORM_IMX_I2C
> -	select IMX_HAVE_PLATFORM_IMX_SSI
>  	select IMX_HAVE_PLATFORM_IMX_FB
>  	select IMX_HAVE_PLATFORM_IMX_KEYPAD
>  	select IMX_HAVE_PLATFORM_IMX_UART
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
