From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 29 May 2012 11:10:57 +0200
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Add sound support
In-Reply-To: <1338051128-29816-1-git-send-email-festevam@gmail.com>
References: <1338051128-29816-1-git-send-email-festevam@gmail.com>
Message-ID: <20120529091057.GC30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 26, 2012 at 01:52:08PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks

Sascha

> ---
>  arch/arm/configs/imx_v6_v7_defconfig |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index b1d3675..59beb7a 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -131,6 +131,8 @@ CONFIG_GPIO_SYSFS=y
>  CONFIG_WATCHDOG=y
>  CONFIG_IMX2_WDT=y
>  CONFIG_MFD_MC13XXX=y
> +CONFIG_MFD_MC13XXX_SPI=y
> +CONFIG_MFD_MC13XXX_I2C=y
>  CONFIG_REGULATOR=y
>  CONFIG_REGULATOR_FIXED_VOLTAGE=y
>  CONFIG_REGULATOR_MC13783=y
> @@ -166,6 +168,14 @@ CONFIG_LOGO=y
>  CONFIG_LOGO_LINUX_MONO=y
>  CONFIG_LOGO_LINUX_VGA16=y
>  CONFIG_LOGO_LINUX_CLUT224=y
> +CONFIG_SOUND=y
> +CONFIG_SND=y
> +CONFIG_SND_SOC=y
> +CONFIG_SND_IMX_SOC=y
> +CONFIG_SND_SOC_PHYCORE_AC97=y
> +CONFIG_SND_SOC_EUKREA_TLV320=y
> +CONFIG_SND_SOC_IMX_SGTL5000=y
> +CONFIG_SND_SOC_IMX_MC13783=y
>  CONFIG_USB=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_MXC=y
> -- 
> 1.7.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
