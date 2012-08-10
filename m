From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 10 Aug 2012 11:04:28 +0200
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Add Chipidea USB driver support
In-Reply-To: <1344463589-8115-1-git-send-email-festevam@gmail.com>
References: <1344463589-8115-1-git-send-email-festevam@gmail.com>
Message-ID: <20120810090428.GW1451@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 07:06:29PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Add Chipidea USB driver support.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks (to the defconfig branch btw)

Sascha

> ---
>  arch/arm/configs/imx_v6_v7_defconfig |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index f725b96..5f6138d 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -179,6 +179,9 @@ CONFIG_SND_SOC_IMX_MC13783=y
>  CONFIG_USB=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_MXC=y
> +CONFIG_USB_CHIPIDEA=y
> +CONFIG_USB_CHIPIDEA_HOST=y
> +CONFIG_USB_MXS_PHY=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_MMC=y
>  CONFIG_MMC_SDHCI=y
> -- 
> 1.7.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
