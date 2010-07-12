From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 12 Jul 2010 16:29:40 -0400 (EDT)
Subject: ARM defconfig files
In-Reply-To: <20100712200604.GD9897@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1006030725420.8175@i5.linux-foundation.org>
	<20100603181010.GA25779@flint.arm.linux.org.uk>
	<1275589230.23384.19.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1006031119440.8175@i5.linux-foundation.org>
	<20100614083214.GA2104@pengutronix.de>
	<20100630104043.GG11746@pengutronix.de>
	<20100712155518.GA24144@pengutronix.de>
	<AANLkTilhI9O6YwnuAylo_jNgwR8VXmpSVJ1kylIYPCGT@mail.gmail.com>
	<20100712173228.GC9897@n2100.arm.linux.org.uk>
	<AANLkTinxUqzxClVDTyruJ6kzFTganXUGJJHJ5wRi9Iak@mail.gmail.com>
	<20100712200604.GD9897@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1007121619100.10598@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 12 Jul 2010, Russell King - ARM Linux wrote:

> On Mon, Jul 12, 2010 at 10:40:36AM -0700, Linus Torvalds wrote:
> > On Mon, Jul 12, 2010 at 10:32 AM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > >
> > > When you brought up the problem you seemed absolutely convinced
> > > that nothing except your solution was going to be acceptable.
> > 
> > That's not true. What's true is that you didn't seem to _understand_
> > my solution, so I tried to push the understanding of it.
> 
> That's your point of view.
> 
> My viewpoint was that I had read your email, thought of some alternative
> solution, proposed it and the result was shot down without any apparant
> thought about it.  That gave the impression that you _only_ wanted to
> see your own solution.

OK, please let's put this appearance of misunderstanding behind.  
The rehashing of it from either parties doesn't produce any good.

> The result of that has been very little in the way of progress towards
> either your, or my alternative solutions - and apart from a few Kconfig
> corner quirk patches, the only major work that's happened has been from
> Uwe.

For the record, I do support Uwe's work too.  I do wish it could go in 
now so that from that point going forward we could only focus on 
improving the thing instead of having to care about implications during 
the merge window.

But I do prefer RMK's proposal in the long run.  Not only is it more 
expressive and clear, but it is easier to maintain going forward too.  
But that transition cannot be automated and I doubt the majority of 
targets will be converted anytime soon if at all.  So at least Uwe's 
reduction is quite a good compromise for those.


Nicolas
