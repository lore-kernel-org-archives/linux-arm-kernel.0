From: tony@atomide.com (Tony Lindgren)
Date: Tue, 25 Oct 2011 10:31:57 +0200
Subject: GIC MULTI_IRQ_HANDLER branches
In-Reply-To: <20111025082855.GB9290@n2100.arm.linux.org.uk>
References: <20111024162612.728acd58@taxman.wild-wind.fr.eu.org>
	<20111025074815.GG4429@atomide.com>
	<20111025082855.GB9290@n2100.arm.linux.org.uk>
Message-ID: <20111025083157.GK4429@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [111025 09:54]:
> On Tue, Oct 25, 2011 at 09:48:16AM +0200, Tony Lindgren wrote:
> > * Marc Zyngier <maz@misterjones.org> [111024 16:59]:
> > > I've stashed my patches for MULTI_IRQ_HANDLER on the following branches:
> > > git://github.com/mzyngier/arm-platforms.git gic-multi-irq
> > > git://github.com/mzyngier/arm-platforms.git gic-multi-irq-asm
> > > 
> > > This is based on Russell's smp branch, plus my PPI patches that Russell
> > > has already pulled for the upcoming merge window.
> > > 
> > > The difference between the two branches is that the second is keeping
> > > the ASM version of the GIC handler instead of a C version.
> > > 
> > > The C version has been tested on VE, Realview, Tegra, and OMAP2/3/4.
> > > The ASM version has only been tested on OMAP4.
> > 
> > For the record, boots fine on omap1/2/3/4 like I replied earlier
> > with my Tested-by.
> > 
> > Can people please test this series on all subarchs so Marc can
> > then remove the remaining assembly code too.
> 
> My feeling is that this is too disruptive to take for 3.2 now that the
> merge window is open: just adding Marc's PPI patches on Sunday caused
> a number of _horrible_ conflicts crop up.  This probably is no
> different.
> 
> So, let's postpone this kind of stuff until after this merge window has
> closed.

OK, I was hoping we could get it in without the assembly changes..
 
> (BTW, Linus won't be pulling major stuff which hasn't been in linux-next -
> see the 3.1 announcement.)

..but yeah I guess it's too late now.

Tony
