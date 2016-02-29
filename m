From: mgr@pengutronix.de (Michael Grzeschik)
Date: Mon, 29 Feb 2016 11:23:39 +0100
Subject: [PATCH 1/2] ARM: imx_v4_v5_defconfig: Cleanup imx_v4_v5_defconfig
In-Reply-To: <20160229025822.GO22051@tiger>
References: <1456325867-5309-1-git-send-email-m.grzeschik@pengutronix.de>
 <20160229025822.GO22051@tiger>
Message-ID: <20160229102339.GA4754@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 10:58:22AM +0800, Shawn Guo wrote:
> On Wed, Feb 24, 2016 at 03:57:46PM +0100, Michael Grzeschik wrote:
> > @@ -169,12 +167,11 @@ CONFIG_RTC_DRV_IMXDI=y
> >  CONFIG_RTC_DRV_MC13XXX=y
> >  CONFIG_RTC_DRV_MXC=y
> >  CONFIG_DMADEVICES=y
> > -CONFIG_IMX_SDMA=y
> >  CONFIG_IMX_DMA=y
> > +CONFIG_IMX_SDMA=y
> >  # CONFIG_IOMMU_SUPPORT is not set
> >  CONFIG_EXT2_FS=y
> >  CONFIG_EXT3_FS=y
> > -CONFIG_EXT4_FS=y
> 
> I guess that Arnd's comment about keeping CONFIG_EXT4_FS and dropping
> the other two applies here too?

Sure, I missed that. Will send v2 in a second.

Thanks,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
