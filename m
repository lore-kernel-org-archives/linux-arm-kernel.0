From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Dec 2015 16:49:38 +0100
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <20151202123310.GC8644@n2100.arm.linux.org.uk>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <87610j7gmc.fsf@free-electrons.com>
 <20151202123310.GC8644@n2100.arm.linux.org.uk>
Message-ID: <3059482.yN34NFeWWY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 December 2015 12:33:10 Russell King - ARM Linux wrote:
> On Mon, Nov 30, 2015 at 02:37:31PM +0100, Gregory CLEMENT wrote:
> > Hi Arnd,
> >  
> >  On mer., nov. 25 2015, Arnd Bergmann <arnd@arndb.de> wrote:
> > 
> > > I've posted these before and now gotten around to a rebase and
> > > want to include them in the arm-soc next/multiplatform branch for
> > > 4.5.
> > >
> > > Originally the plan for these platforms was to convert all of
> > > them to DT and use only mach-mvebu. That has not happened,
> > > so I would do it this way instead so we can at least have
> > > them in a single kernel.
> > >
> > > Let me know if there are any concerns or objections.
> > 
> > I have applied all the patches on mvebu/oldmvebu_multiplatform (I fixed
> > the last one which didn't apply on Kconfig). I also merged it
> > mvebu/for-netx to be part of the linux-next.
> > 
> > But before making it part of mvebu/soc, I would like to get some
> > Tested-by. The series is available on
> > git://git.infradead.org/linux-mvebu.git
> > in the branch mvebu/oldmvebu_multiplatform but it also will be part soon
> > of linux-next.
> > 
> > Russell, Sebastian,
> > 
> > would you have some time to test it on Dove?
> 
> Given that I'm testing on my Cubox tree, I've applied this series on top
> of v4.3.  Patch 5 trivially conflicts on MMP context.  Fixing that and
> merging the resulting changes gives another load of conflicts which need
> dealing with:
> 
> Recorded preimage for 'arch/arm/Kconfig'
> Recorded preimage for 'arch/arm/mach-dove/Kconfig'
> Recorded preimage for 'arch/arm/mach-dove/irq.c'
> Recorded preimage for 'arch/arm/mach-dove/pm.h'
> 
> These look less trivial to resolve, so testing this will have to wait
> until I have sufficient time to sort this out.

I have pushed a rebased version to
git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git multiplatform-orion-4.3

Maybe that helps

	Arnd
