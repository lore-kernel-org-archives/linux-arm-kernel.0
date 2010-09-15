From: tony@atomide.com (Tony Lindgren)
Date: Wed, 15 Sep 2010 16:15:00 -0700
Subject: [PATCH] omap: Update omap3_defconfig to work with SMP_ON_UP
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02CD25FF3B@dbde02.ent.ti.com>
References: <20100817104414.19061.38999.stgit@baageli.muru.com>
	<20100906104413.GD20903@n2100.arm.linux.org.uk>
	<20100914185907.GG8647@atomide.com>
	<20100914190314.GH8647@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD25F7DB@dbde02.ent.ti.com>
	<20100914202743.GK8647@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD25F9E1@dbde02.ent.ti.com>
	<20100915161126.GS8647@atomide.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02CD25FF3B@dbde02.ent.ti.com>
Message-ID: <20100915231500.GK4174@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Shilimkar, Santosh <santosh.shilimkar@ti.com> [100915 11:18]:
> > 
> Here is the patch which fixes most of the omap4 issues with common
> Omap3_defconfig. 

Good to hear, thanks!
 
> To enable local Timers for es1.0, I made some progress but looks like 
> it needs more changes in generic code. Will have a look at it tomorrow.

OK
 
> The patch is on top of the patches being discussed here. It's boot-tested 
> with single image on OMAP3 and OMAP4 SMP.

Looks good to me.

Tony
