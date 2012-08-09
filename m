From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 9 Aug 2012 08:32:58 +0200
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Add Chipidea USB driver support
In-Reply-To: <50234E6F.1050406@de.bosch.com>
References: <1344463589-8115-1-git-send-email-festevam@gmail.com>
 <50234E6F.1050406@de.bosch.com>
Message-ID: <20120809063258.GN1451@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 09, 2012 at 07:45:19AM +0200, Dirk Behme wrote:
> On 09.08.2012 00:06, Fabio Estevam wrote:
> >From: Fabio Estevam <fabio.estevam@freescale.com>
> >
> >Add Chipidea USB driver support.
> >
> >Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> >---
> > arch/arm/configs/imx_v6_v7_defconfig |    3 +++
> > 1 files changed, 3 insertions(+), 0 deletions(-)
> >
> >diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> >index f725b96..5f6138d 100644
> >--- a/arch/arm/configs/imx_v6_v7_defconfig
> >+++ b/arch/arm/configs/imx_v6_v7_defconfig
> >@@ -179,6 +179,9 @@ CONFIG_SND_SOC_IMX_MC13783=y
> > CONFIG_USB=y
> > CONFIG_USB_EHCI_HCD=y
> > CONFIG_USB_EHCI_MXC=y
> >+CONFIG_USB_CHIPIDEA=y
> >+CONFIG_USB_CHIPIDEA_HOST=y
> >+CONFIG_USB_MXS_PHY=y
> > CONFIG_USB_STORAGE=y
> > CONFIG_MMC=y
> > CONFIG_MMC_SDHCI=y
> 
> I'm not sure if we still need
> 
> CONFIG_USB_EHCI_HCD=y
> CONFIG_USB_EHCI_MXC=y
> 
> or if this can be removed? Besides this:

It is still needed for the non devicetree platforms.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
