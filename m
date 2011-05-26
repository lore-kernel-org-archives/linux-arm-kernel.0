From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 26 May 2011 10:59:19 +0100
Subject: [RFC] ARM Subarchitecture group maintainership
In-Reply-To: <alpine.LFD.2.02.1105261030560.3078@ionos>
References: <201105181047.17309.arnd@arndb.de>
	<BANLkTi=xzrLhHTBynWf4huA9EusfaDwPbA@mail.gmail.com>
	<20110525075902.GH30799@atomide.com>
	<alpine.LFD.2.00.1105251021550.3207@xanadu.home>
	<20110525153459.GE27250@atomide.com>
	<alpine.LFD.2.02.1105251803120.3078@ionos>
	<20110526082807.GA11783@sirena.org.uk>
	<alpine.LFD.2.02.1105261030560.3078@ionos>
Message-ID: <20110526095919.GA31268@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 26, 2011 at 10:33:55AM +0200, Thomas Gleixner wrote:
> On Thu, 26 May 2011, Mark Brown wrote:

> > I think the question is about the existing -next branches people already
> > have - should they contain code that hasn't yet gone to you guys?  We're
> > doing that for audio at the minute (having subtrees in -next directly)
> > and it's pretty helpful for miniising hassle for the maintainers of the
> > core tree.

> We obviously talk about arch/arm/[mach|plat]* stuff, drivers/ sound/
> etc. should go through the relevant maintainer trees.

Right, but the question is what to do with the subtrees that are in
-next currently.  I'm mentioning sound as an example of a tree with
subtrees in -next directly.
