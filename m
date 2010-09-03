From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 3 Sep 2010 11:55:04 +0200
Subject: [PATCH 4/5] [ARM] Auto calculate ZRELADDR and provide option
	for exceptions
In-Reply-To: <20100903074806.GX14214@pengutronix.de>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-5-git-send-email-eric.miao@canonical.com>
	<20100902212145.GA15264@n2100.arm.linux.org.uk>
	<20100902212723.GC26319@n2100.arm.linux.org.uk>
	<20100903074806.GX14214@pengutronix.de>
Message-ID: <20100903095504.GC13643@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Fri, Sep 03, 2010 at 09:48:06AM +0200, Uwe Kleine-K?nig wrote:
> On Thu, Sep 02, 2010 at 10:27:23PM +0100, Russell King - ARM Linux wrote:
> > 
> > And while we're here, why hasn't anyone removed the zreladdr
> > definitions in Makefile.boot yet?  Or do we still need them and
> > we now have the same information defined in two different places?
> > 
> > This all looks like a half-done job at the moment.  Please clean it up.
> The original series removed all the 'Makefile.boot's IIRC.  Currently
> the params_phys-y value is needed though.  So should I send a patch that
> just removes the zreladdr values?
I looked into that and found some more issues.  I hope I catched them
all now.  While doing that removing the zreladdr lines was nearly for
free.  So I did that, too.

I couldn't determine who to cc: for the ARCH_H720X patch.  Russell, do
you maintain this platform?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
