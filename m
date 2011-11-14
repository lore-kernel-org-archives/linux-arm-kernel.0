From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 14 Nov 2011 16:47:09 +0100
Subject: [PATCH 3/3] ARM i.MX: Update defconfig
In-Reply-To: <20111114015828.GB10217@S2100-06.ap.freescale.net>
References: <1320915966-8063-1-git-send-email-s.hauer@pengutronix.de>
 <1320915966-8063-4-git-send-email-s.hauer@pengutronix.de>
 <20111114015828.GB10217@S2100-06.ap.freescale.net>
Message-ID: <20111114154709.GC27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2011 at 09:58:29AM +0800, Shawn Guo wrote:
> Hi Sascha,
> 
> On Thu, Nov 10, 2011 at 10:06:06AM +0100, Sascha Hauer wrote:
> > This updates the defconfig for i.MX3, i.MX5 and i.MX6.
> > 
> > - all these can be compiled together now, so remove mx3_defconfig and
> >   mx5_defconfig and introduce a imx_v6_v7_defconfig instead.
> > 
> Can you amend the following change to imx_v6_v7_defconfig?  With this
> change, CONFIG_MMC_BLOCK will become built-in and I can boot the kernel
> with Linaro rootfs on SD/MMC, which is a pretty nice thing for some
> people.

Ok, no problem.

Sascha

> 
> Regards,
> Shawn
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 2fbcaef..3a4fb2e 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -132,7 +132,6 @@ CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_MXC=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_MMC=y
> -CONFIG_MMC_BLOCK=m
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_PLTFM=y
>  CONFIG_MMC_SDHCI_ESDHC_IMX=y
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
