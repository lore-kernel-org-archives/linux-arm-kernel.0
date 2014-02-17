From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 17 Feb 2014 14:32:30 -0500
Subject: [GIT PULL] irqchip: dove: drivers for v3.14
In-Reply-To: <20140207180836.GE8533@titan.lakedaemon.net>
References: <20131201172914.GV2879@titan.lakedaemon.net>
 <20131211175037.GY10053@titan.lakedaemon.net>
 <20140110183430.GO19878@titan.lakedaemon.net>
 <20140128173531.GT29184@titan.lakedaemon.net>
 <alpine.DEB.2.02.1402041959110.24986@ionos.tec.linutronix.de>
 <20140204211219.GK8533@titan.lakedaemon.net>
 <alpine.DEB.2.02.1402042230230.24986@ionos.tec.linutronix.de>
 <20140207180836.GE8533@titan.lakedaemon.net>
Message-ID: <20140217193230.GW7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Fri, Feb 07, 2014 at 01:08:36PM -0500, Jason Cooper wrote:
> On Tue, Feb 04, 2014 at 10:30:53PM +0100, Thomas Gleixner wrote:
> > On Tue, 4 Feb 2014, Jason Cooper wrote:
> > 
> > > On Tue, Feb 04, 2014 at 07:59:58PM +0100, Thomas Gleixner wrote:
> > > > On Tue, 28 Jan 2014, Jason Cooper wrote:
> > > > > I see you pulled in mvebu/irqchip-fixes.  Thanks for that.  It's getting
> > > > > near to the end of the merge window and there's been no activity on this
> > > > > pull request.
> > > > > 
> > > > > Please let us know if there's anything we can do to assist.
> > > > 
> > > > Nah. I simply forgot about it. About to send a pull request to Linus.
> > > 
> > > hmmm.  I see the pull request contains the patches from
> > > mvebu/irqchip-fixes (armada), but not the patches from mvebu/irqchip
> > > (dove):
> > > 
> > >   40b367d95fb3 irqchip: irq-dove: Add PMU interrupt controller.
> > > 
> > > which is what this thread was originally a pull request for.
> > > 
> > > 
> > > Are you planning to send a second pull request to Linus?
> > 
> > Duh. I'll pick that up tomorrow
> 
> Ping?

I think it's safe to say that the Dove PMU interrupt controller isn't
going to make it in to v3.14.  I've posted a patch to remove the DT node
for v3.14.

If you don't mind, I'll go ahead and take this pull request through the
mvebu tree for v3.15.  So that way it's off your plate and you don't
have to worry about it.

There's more mvebu irqchip stuff on the way :)

thx,

Jason.
