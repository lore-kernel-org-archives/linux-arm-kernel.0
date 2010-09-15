From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 15 Sep 2010 23:55:50 +0530
Subject: [PATCH] omap: Update omap3_defconfig to work with SMP_ON_UP
In-Reply-To: <20100915161126.GS8647@atomide.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
	<20100906104413.GD20903@n2100.arm.linux.org.uk>
	<20100914185907.GG8647@atomide.com> <20100914190314.GH8647@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD25F7DB@dbde02.ent.ti.com>
	<20100914202743.GK8647@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD25F9E1@dbde02.ent.ti.com>
	<20100915161126.GS8647@atomide.com>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD25FF3B@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Tony Lindgren [mailto:tony at atomide.com]
> Sent: Wednesday, September 15, 2010 9:41 PM
> To: Shilimkar, Santosh
> Cc: Russell King - ARM Linux; linux-arm-kernel at lists.infradead.org; linux-
> omap at vger.kernel.org; bryan.wu at canonical.com
> Subject: Re: [PATCH] omap: Update omap3_defconfig to work with SMP_ON_UP
> 
> * Shilimkar, Santosh <santosh.shilimkar@ti.com> [100914 23:03]:
> > >
> > > Sounds like you're having these problems anyways and they
> > > are not related to the defconfigs?
> > >
> > Well the issues are because of defconfig but mostly fixable.
> > Will hold on my comments till I test the new defconfig on OMAP4.
> 
> OK
> 
> > > Considering Linus' earlier comments on the defconfigs, I don't
> > > see any reasonds not to merge this patch. If TI wants to fix up
> > > some other things, there's still about two weeks before -rc6.
> > >
> > Sure. I am just saying let's attempt to fix the remaining issues
> > and if it doesn't happen in next week, anyway this patch will
> > get merged.
> 
> OK let's plan on doing that.
> 
Here is the patch which fixes most of the omap4 issues with common
Omap3_defconfig. 

To enable local Timers for es1.0, I made some progress but looks like 
it needs more changes in generic code. Will have a look at it tomorrow.

The patch is on top of the patches being discussed here. It's boot-tested 
with single image on OMAP3 and OMAP4 SMP.
