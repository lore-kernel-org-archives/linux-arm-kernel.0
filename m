From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 16 Feb 2011 05:28:14 +0800
Subject: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
In-Reply-To: <20110214153952.GE10709@pengutronix.de>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
	<1297650746-12841-2-git-send-email-shawn.guo@freescale.com>
	<20110214153952.GE10709@pengutronix.de>
Message-ID: <20110215212813.GG10990@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Mon, Feb 14, 2011 at 04:39:52PM +0100, Wolfram Sang wrote:
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index afe8c6f..42a9e21 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -319,6 +319,15 @@ config MMC_MXC
> >  
> >  	  If unsure, say N.
> >  
> > +config MMC_MXS
> > +	tristate "Freescale MXS Multimedia Card Interface support"
> > +	depends on ARCH_MXS
> > +	help
> > +	  This selects the Freescale SSP MMC controller found on MXS based
> > +	  platforms like mx23/28.
> > +
> > +	  If unsure, say N.
> > +
> 
> It should also depend on MXS_DMA?
> 
Good point.  Will do.

Regards,
Shawn
