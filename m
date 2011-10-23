From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 23 Oct 2011 10:47:23 +0100
Subject: [RFC][PATCH] uncompress.h cleanup and DT support
In-Reply-To: <20111023094309.GM15299@pengutronix.de>
References: <CAGVye5MSqdxh0DzCMt79sKk+Z0Trfro0RNDr-4zccMh7O7vGiA@mail.gmail.com>
	<20111023084132.GA12814@n2100.arm.linux.org.uk>
	<CAGVye5NQa857oNPEgQBWE0twQHL6U3BTeSOaR2aTiJzUxMvFSg@mail.gmail.com>
	<20111023092059.GB12814@n2100.arm.linux.org.uk>
	<20111023094309.GM15299@pengutronix.de>
Message-ID: <20111023094723.GC12814@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 23, 2011 at 11:43:09AM +0200, Uwe Kleine-K?nig wrote:
> On Sun, Oct 23, 2011 at 10:20:59AM +0100, Russell King - ARM Linux wrote:
> > On Sun, Oct 23, 2011 at 11:12:50AM +0200, Zoltan Devai wrote:
> > > 2011/10/23 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > > > On Sun, Oct 23, 2011 at 10:18:29AM +0200, Zoltan Devai wrote:
> > > >> Plase consider all this as RFC, it's mostly not even compile-tested.
> > > >> If you think it's worth to follow-up, I'm happy to do it.
> > > >
> > > > Is the patch available?
> > > git://github.com/zdevai/linux.git uncompress-h
> > 
> > I'd rather not pull your tree just to look at the patch.  Is it
> > available somewhere else?
> It's not hard to look at it and no need to pull, just do:
> 
> 	git fetch git://github.com/zdevai/linux.git uncompress-h
> 	git log -p ..FETCH_HEAD

.1 We do reviews in patch form on mailing lists, not from commits inside
   git trees.

.2 I don't even want to pull the objects into my tree - that's a waste of
   bandwidth just to _read_ the patch, and risks pulling in a lot more
   depending on the parents of the commit.

So, please stick to patch form.  If it's too large for the mailing list,
please split the patch up into a logical sequence of steps as individual
patches.  Only then provide a gitweb URL if that's not possible.

If the diffstat at the start of this thread reflects a single patch then
it's doing too much as one change.
