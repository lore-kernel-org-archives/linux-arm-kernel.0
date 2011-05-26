From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 26 May 2011 10:33:55 +0200 (CEST)
Subject: [RFC] ARM Subarchitecture group maintainership
In-Reply-To: <20110526082807.GA11783@sirena.org.uk>
References: <201105181047.17309.arnd@arndb.de>
	<BANLkTi=xzrLhHTBynWf4huA9EusfaDwPbA@mail.gmail.com>
	<20110525075902.GH30799@atomide.com>
	<alpine.LFD.2.00.1105251021550.3207@xanadu.home>
	<20110525153459.GE27250@atomide.com>
	<alpine.LFD.2.02.1105251803120.3078@ionos>
	<20110526082807.GA11783@sirena.org.uk>
Message-ID: <alpine.LFD.2.02.1105261030560.3078@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 May 2011, Mark Brown wrote:

> On Wed, May 25, 2011 at 06:06:16PM +0200, Thomas Gleixner wrote:
> > On Wed, 25 May 2011, Tony Lindgren wrote:
> 
> > > What do you want to do with with the various for-next branches?
> 
> > > Do you want to queue things into your tree before hitting for-next?
> 
> > The stuff which gets pulled in from the various suppliers is
> > aggregated in a separate for -next branch.
> 
> I think the question is about the existing -next branches people already
> have - should they contain code that hasn't yet gone to you guys?  We're
> doing that for audio at the minute (having subtrees in -next directly)
> and it's pretty helpful for miniising hassle for the maintainers of the
> core tree.

We obviously talk about arch/arm/[mach|plat]* stuff, drivers/ sound/
etc. should go through the relevant maintainer trees.

Thanks,

	tglx
