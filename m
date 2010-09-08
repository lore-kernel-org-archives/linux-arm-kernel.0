From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Sep 2010 10:11:49 +0100
Subject: [PATCH 4/5] [ARM] Auto calculate ZRELADDR and provide option
	for exceptions
In-Reply-To: <20100903095504.GC13643@pengutronix.de>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-5-git-send-email-eric.miao@canonical.com>
	<20100902212145.GA15264@n2100.arm.linux.org.uk>
	<20100902212723.GC26319@n2100.arm.linux.org.uk>
	<20100903074806.GX14214@pengutronix.de>
	<20100903095504.GC13643@pengutronix.de>
Message-ID: <20100908091149.GC29914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 03, 2010 at 11:55:04AM +0200, Uwe Kleine-K?nig wrote:
> Hello Russell,
> 
> On Fri, Sep 03, 2010 at 09:48:06AM +0200, Uwe Kleine-K?nig wrote:
> > On Thu, Sep 02, 2010 at 10:27:23PM +0100, Russell King - ARM Linux wrote:
> > > 
> > > And while we're here, why hasn't anyone removed the zreladdr
> > > definitions in Makefile.boot yet?  Or do we still need them and
> > > we now have the same information defined in two different places?
> > > 
> > > This all looks like a half-done job at the moment.  Please clean it up.
> > The original series removed all the 'Makefile.boot's IIRC.  Currently
> > the params_phys-y value is needed though.  So should I send a patch that
> > just removes the zreladdr values?
> I looked into that and found some more issues.  I hope I catched them
> all now.  While doing that removing the zreladdr lines was nearly for
> free.  So I did that, too.
> 
> I couldn't determine who to cc: for the ARCH_H720X patch.  Russell, do
> you maintain this platform?

Nope.
