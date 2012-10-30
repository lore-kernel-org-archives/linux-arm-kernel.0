From: tony@atomide.com (Tony Lindgren)
Date: Tue, 30 Oct 2012 16:54:19 -0700
Subject: [GIT PULL] omap plat header removal for v3.8 merge window, part1
In-Reply-To: <20121027163233.GA11908@atomide.com>
References: <20121019023300.GN30550@atomide.com>
 <201210261402.19759.arnd@arndb.de>
 <20121026170949.GF11908@atomide.com>
 <201210261728.22132.arnd@arndb.de>
 <20121026175537.GL11908@atomide.com>
 <20121026223848.GY11908@atomide.com>
 <20121027090210.GJ28061@n2100.arm.linux.org.uk>
 <20121027163233.GA11908@atomide.com>
Message-ID: <20121030235419.GA12739@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [121027 09:34]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [121027 02:03]:
> > 
> > Rather than moving all the files from plat-omap/include/plat into plat-omap
> > and then having all these totally disgusting relative includes, why don't
> > you add to these makefiles:
> > 
> > ccflags += -I$(srctree)/arch/arm/plat-omap/include
> > 
> > and avoid all that include moving and all the include name fixup?
> 
> I'll take a look. Most of these headers should be local,
> so it should not be too many files to move for plat-omap
> to fix this.

Posted a series to fix the issue with relative includes
as "[PATCH 00/11] Fix relative includes for omaps introduced
by recent clean-up".

Regards,

Tony
