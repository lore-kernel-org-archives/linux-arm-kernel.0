From: tony@atomide.com (Tony Lindgren)
Date: Tue, 9 Jun 2015 22:10:38 -0700
Subject: EDMA oftree entry for AM335x
In-Reply-To: <20150608105957.GT26523@pengutronix.de>
References: <20150504064323.GU15254@pengutronix.de>
 <20150504141103.GD24469@atomide.com> <5548CB54.1040302@ti.com>
 <20150505145828.GB21061@atomide.com> <5549F95B.8090905@ti.com>
 <20150506143951.GG21061@atomide.com>
 <20150608105957.GT26523@pengutronix.de>
Message-ID: <20150610051037.GA2740@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Robert Schwebel <r.schwebel@pengutronix.de> [150608 04:01]:
> On Wed, May 06, 2015 at 07:39:52AM -0700, Tony Lindgren wrote:
> > 
> > That may never happen considering that davinci is using it too.. It's
> > best to not count on that happening anytime soon at least.
> 
> So my current understanding is that we have the situation that the
> kernel warns about the oftree being wrong, but isn't able to handle an
> oftree that would be right.
>
> Shouldn't the warning being added when the kernel driver supports that
> new mechanism?

This particular driver is broken and it needs to be fixed properly.
 
> I had a warning free mainline kernel without patches on my customer
> hardware before, so this smells a bit like a regression ... :-/

Yes sorry I'm not patching away the warning as it does not fix the
driver. Peter, I assume you are busy fixing it?

Regards,

Tony
