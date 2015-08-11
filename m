From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Aug 2015 14:55:27 +0200
Subject: [GIT PULL v2] Renesas ARM Based SoC Marzen Board Removal for v4.3
In-Reply-To: <20150811082105.GX7557@n2100.arm.linux.org.uk>
References: <cover.1438581659.git.horms+renesas@verge.net.au>
 <20150806081000.GA16520@localhost>
 <20150807012847.GF1145@verge.net.au>
 <20150811082105.GX7557@n2100.arm.linux.org.uk>
Message-ID: <20150811125527.GB24495@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 11, 2015 at 09:21:05AM +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 07, 2015 at 10:28:47AM +0900, Simon Horman wrote:
> > diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
> > index 8d1e0b6ac2a2..476de30798d7 100644
> > --- a/arch/arm/mach-shmobile/Makefile
> > +++ b/arch/arm/mach-shmobile/Makefile
> > @@ -53,6 +53,7 @@ obj-$(CONFIG_ARCH_RCAR_GEN2)	+= pm-rcar-gen2.o
> >  ifndef CONFIG_ARCH_SHMOBILE_MULTI
> >  obj-$(CONFIG_MACH_BOCKW)	+= board-bockw.o
> >  obj-$(CONFIG_MACH_BOCKW_REFERENCE)	+= board-bockw-reference.o
> > +endif
> >  
> >  # Framework support
> >  obj-$(CONFIG_SMP)		+= $(smp-y)
> 
> What's happening to get this fixed?
> 
> arch/arm/mach-shmobile/Makefile:59: *** missing 'endif'.  Stop.
> Makefile:949: recipe for target 'arch/arm/mach-shmobile' failed
> make[1]: *** [arch/arm/mach-shmobile] Error 2

I've fixed up and pushed out for-next now. Will keep an eye on the build
results in a bit.


-Olof
