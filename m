From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 26 May 2011 21:15:33 -0600
Subject: [PATCH 0/4] add gpio driver gpio-mxs
In-Reply-To: <20110520102410.GD27251@S2100-06.ap.freescale.net>
References: <1305885089-27343-1-git-send-email-shawn.guo@linaro.org>
	<20110520100242.GA10403@pengutronix.de>
	<20110520102410.GD27251@S2100-06.ap.freescale.net>
Message-ID: <20110527031533.GI5032@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 20, 2011 at 06:24:11PM +0800, Shawn Guo wrote:
> On Fri, May 20, 2011 at 12:02:42PM +0200, Sascha Hauer wrote:
> > Hi Shawn,
> > 
> Hi Sascha,
> 
> > On Fri, May 20, 2011 at 05:51:25PM +0800, Shawn Guo wrote:
> > > The patch set is to move Freescale MXS gpio driver from mach-mxs
> > > into drivers/gpio.  Different from u300 gpio driver that all gpio
> > > ports are registered as one device, gpio-mxs expects every single
> > > port is a gpio device.
> > > 
> > > The first 3 patches are just to ease review and can be squashed into
> > > the last one.
> > > 
> > > Shawn Guo (4):
> > >       gpio: gpio-mxs: add file gpio-mxs.c
> > >       gpio: gpio-mxs: drop mach-specific accessors
> > >       gpio: gpio-mxs: remove gpio port definition and registration
> > >       gpio: gpio-mxs: add gpio driver for Freescale MXS architecture
> > 
> > Your series should be bisectible. So please either:
> > 
> > - Add the driver the way you want it (no need to modify a new file in
> >   four steps)
> 
> As I said above, I split it into 4 patches just to ease the review,
> and they can be squashed into one when applying.

If you use the -M flag when posting the patch, then the diff will show
both that the file has moved, and also only show the changes made to
the file when it was moved.  That way you can squash the series into
one.

g.
