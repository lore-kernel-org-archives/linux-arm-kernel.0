From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 15 Jun 2012 09:42:46 +0200
Subject: [PATCH] ARM: imx_v4_v5_defconfig: Allow booting from MMC card
In-Reply-To: <1339594768-20847-1-git-send-email-fabio.estevam@freescale.com>
References: <1339594768-20847-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120615074246.GX30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 10:39:28AM -0300, Fabio Estevam wrote:
> Allow booting from MMC card.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.

Sascha

> ---
>  arch/arm/configs/imx_v4_v5_defconfig |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
> index e05a2f1..5afc108 100644
> --- a/arch/arm/configs/imx_v4_v5_defconfig
> +++ b/arch/arm/configs/imx_v4_v5_defconfig
> @@ -160,6 +160,12 @@ CONFIG_USB_EHCI_MXC=y
>  CONFIG_USB_ULPI=y
>  CONFIG_MMC=y
>  CONFIG_MMC_MXC=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_PLTFM=y
> +CONFIG_MMC_SDHCI_ESDHC_IMX=y
> +CONFIG_EXT2_FS=y
> +CONFIG_EXT3_FS=y
> +CONFIG_EXT4_FS=y
>  CONFIG_NEW_LEDS=y
>  CONFIG_LEDS_CLASS=y
>  CONFIG_LEDS_GPIO=y
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
