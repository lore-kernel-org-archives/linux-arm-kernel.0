From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 23 Feb 2011 11:09:32 +0800
Subject: [PATCH v3 2/2] ARM: mxs: add dma device
In-Reply-To: <20110222183036.GB22310@pengutronix.de>
References: <1298284306-14710-1-git-send-email-shawn.guo@freescale.com>
	<1298284306-14710-3-git-send-email-shawn.guo@freescale.com>
	<20110222080928.GS22310@pengutronix.de>
	<20110222122733.GD19871@S2100-06.ap.freescale.net>
	<20110222183036.GB22310@pengutronix.de>
Message-ID: <20110223030931.GA20346@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On Tue, Feb 22, 2011 at 07:30:36PM +0100, Uwe Kleine-K?nig wrote:
> Hi Shawn,
> 
> On Tue, Feb 22, 2011 at 08:27:34PM +0800, Shawn Guo wrote:
> > > > diff --git a/arch/arm/mach-mxs/devices/platform-dma.c b/arch/arm/mach-mxs/devices/platform-dma.c
> > > > new file mode 100644
> > > > index 0000000..ee3220e
> > > > --- /dev/null
> > > > +++ b/arch/arm/mach-mxs/devices/platform-dma.c
> > > I'd prefer to have that called platform-mxs-dma.c to match the driver
> > > name.  (At least that's what you use for the data structs.)
> > > 
> > If you put this comment a little bit earlier on platform-auart.c which
> > is the first example that saves the "mxs" from driver name, I would
> > have platform-mxs-dma.c and platform-mxs-mmc.c from the start.
> I already noticed I missed auart and planned to follow up with a patch.
> Sorry if this resulted in an extra iteration for you.
> 
Can we keep it as it is for now, and get your patch fix this
"mxs global" thing?

Sascha plans to rename fb.h to mxsfb.h, and I'm not sure if you will
do the same to rename dma.h and mmc.h under mach-mxs/include/mach to
align everything with driver name.  Just a reminder, this will
require changes in dma and mmc drivers accordingly, also will bring
plat-mxc a mxs-dma.h later support gpmi with mxs dma.

-- 
Regards,
Shawn
