From: manjugk@ti.com (G, Manjunath Kondaiah)
Date: Tue, 28 Sep 2010 21:05:02 +0530
Subject: [GIT PULL] omap2 sparse fixes
In-Reply-To: <20100928152139.GB3117@atomide.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E9402785A390E@dbde02.ent.ti.com>
	<20100923225851.GR4211@atomide.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F859E@dbde02.ent.ti.com>
	<20100925001914.GO4211@atomide.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F917C@dbde02.ent.ti.com>
	<20100928152139.GB3117@atomide.com>
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB3F94C9@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Tony Lindgren [mailto:tony at atomide.com] 
> Sent: Tuesday, September 28, 2010 8:52 PM
> To: G, Manjunath Kondaiah
> Cc: linux-omap at vger.kernel.org; 
> linux-arm-kernel at lists.infradead.org; Samuel Ortiz; Dmitry 
> Torokhov; linux-mtd at lists.infradead.org; Russell King - ARM Linux
> Subject: Re: [GIT PULL] omap2 sparse fixes
> 
> * G, Manjunath Kondaiah <manjugk@ti.com> [100928 01:04]:
> > 
> > Three patches are fixed using above method which are:
> > OMAP: mach-omap2: Fix static function warnings
> > OMAP: plat-omap: Fix static function warnings TWL IRQ: Fix fucntion 
> > declaration warnings
> 
> OK thanks.
>  
> > are available in the git repository at:
> > 
> >   git://dev.omapzoom.org/pub/scm/manju/kernel-omap3-dev.git 
> > sparse_fixes_v3
> > 
> > G, Manjunath Kondaiah (10):
> >       OMAP: mach-omap2: Fix incorrect assignment warnings
> >       OMAP: mach-omap2: Fix static declaration warnings
> >       OMAP2plus: Fix static function warnings
> >       OMAP: mach-omap2: Fix miscellaneous sparse warnings
> >       OMAP: plat-omap: Fix static function warnings
> >       OMAP: NAND: Fix static declaration warning
> >       TWL CORE: Fix sparse warning
> >       TWL IRQ: Fix fucntion declaration warnings
> 
> Didn't Samuel just reply that he has applied these two TWL fixes?

Samuel applied only one patch and other patch is yet to be applied.
Do you want me to pull out these two twl patches from the series?

-Manjunath
