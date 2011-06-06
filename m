From: kernel@wantstofly.org (Lennert Buytenhek)
Date: Mon, 6 Jun 2011 19:34:38 +0200
Subject: [PATCH] ep93xx-eth: convert to phylib
In-Reply-To: <201106060715.52332.florian@openwrt.org>
References: <201106051957.36492.florian@openwrt.org>
	<201106052029.24742.f.fainelli@gmail.com>
	<20110605.140657.1039864716002412071.davem@davemloft.net>
	<201106060715.52332.florian@openwrt.org>
Message-ID: <20110606173438.GC11275@wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 06, 2011 at 07:15:52AM +0200, Florian Fainelli wrote:

> > Instead there are several different people submitting changes to
> > this one driver and I haven't got a clue who is authoritative and
> > who is not.
> > 
> > So 9 times out of ten I'm not going to merge anything submitted
> > in this way unless I start to see lots of ACKs from other developers.
> > 
> > When it gets to the point where multiple people are touching the
> > driver in all sorts of ways, there needs to be someone to do all of
> > the merging and making sure the patches get applied in the right order
> > and handling merge conflicts handled properly.  Then they submit them
> > formally here as a sane single set of patches to the list.
> > 
> > So who is going to step up and be the ep93xx-eth maintainer?  Lennert
> > is listed in MAINTAINERS, but I see little to no activity from him.
> 
> Lennert, do you still have time, hardware and will to maintain that driver?

I still have hardware, but I have been pretty short on time lately.
I'd be happy to hand over maintainership of this driver.
