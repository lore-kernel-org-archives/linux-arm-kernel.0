From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 22 Feb 2011 19:30:36 +0100
Subject: [PATCH v3 2/2] ARM: mxs: add dma device
In-Reply-To: <20110222122733.GD19871@S2100-06.ap.freescale.net>
References: <1298284306-14710-1-git-send-email-shawn.guo@freescale.com>
	<1298284306-14710-3-git-send-email-shawn.guo@freescale.com>
	<20110222080928.GS22310@pengutronix.de>
	<20110222122733.GD19871@S2100-06.ap.freescale.net>
Message-ID: <20110222183036.GB22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Tue, Feb 22, 2011 at 08:27:34PM +0800, Shawn Guo wrote:
> > > diff --git a/arch/arm/mach-mxs/devices/platform-dma.c b/arch/arm/mach-mxs/devices/platform-dma.c
> > > new file mode 100644
> > > index 0000000..ee3220e
> > > --- /dev/null
> > > +++ b/arch/arm/mach-mxs/devices/platform-dma.c
> > I'd prefer to have that called platform-mxs-dma.c to match the driver
> > name.  (At least that's what you use for the data structs.)
> > 
> If you put this comment a little bit earlier on platform-auart.c which
> is the first example that saves the "mxs" from driver name, I would
> have platform-mxs-dma.c and platform-mxs-mmc.c from the start.
I already noticed I missed auart and planned to follow up with a patch.
Sorry if this resulted in an extra iteration for you.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
