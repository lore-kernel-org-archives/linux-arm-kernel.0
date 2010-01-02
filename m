From: jsun@junsun.net (Jun Sun)
Date: Sat, 2 Jan 2010 09:26:24 -0800
Subject: [PATCH] Valid relocation symbol for FLAT format on ARM
In-Reply-To: <20100101204605.GH16220@n2100.arm.linux.org.uk>
References: <52886e760912300830n2234e01bm2e300828141d226@mail.gmail.com>
	<20091230184929.GB22469@shareable.org>
	<20100101204605.GH16220@n2100.arm.linux.org.uk>
Message-ID: <20100102172624.GA17222@Pogoplug>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 01, 2010 at 08:46:05PM +0000, Russell King - ARM Linux wrote:
> On Wed, Dec 30, 2009 at 06:49:29PM +0000, Jamie Lokier wrote:
> > ps. Russell, proof that someone is using no-MMU ARM? :-)
> > I'll get back to your earlier mail on that subject when I have more
> > time, btw.
> 
> Two users, at Christmas no less.  I suspect they're only playing with
> uclinux because they're bored over the holiday season. ;)
> 

Kind of. :) We are usually pretty busy with commercial work during 
normal days. Get a little more time for community work over the holiday.

> Really though, if uclinux on ARM is being used, it needs more visible
> activity to ensure that it gets tested.  What was merged from Hyok's
> efforts is only half the story - just the core code.  AFAIK, everything
> else went in the circular filing cabinet.
> 
> Catalin did some work to bring one of the ARM boards up with a uclinux
> kernel, and some of those patches were merged, but without any configs.
> 
> This in turn means is that we don't have any uclinux defconfigs, so we
> don't have kautobuild running any uclinux builds - which effectively means
> we have zero build coverage on uclinux.  We don't know when it breaks,
> etc.

I think I or one of my colleagues can submit a working patch with defconfig 
for a commercially available ARM7 board soon. 

Will submit a revised v3 patch in a sec.

Cheers.

Jun
