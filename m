From: tony@atomide.com (Tony Lindgren)
Date: Sat, 27 Oct 2012 09:32:34 -0700
Subject: [GIT PULL] omap plat header removal for v3.8 merge window, part1
In-Reply-To: <20121027090210.GJ28061@n2100.arm.linux.org.uk>
References: <20121019023300.GN30550@atomide.com>
 <201210261402.19759.arnd@arndb.de>
 <20121026170949.GF11908@atomide.com>
 <201210261728.22132.arnd@arndb.de>
 <20121026175537.GL11908@atomide.com>
 <20121026223848.GY11908@atomide.com>
 <20121027090210.GJ28061@n2100.arm.linux.org.uk>
Message-ID: <20121027163233.GA11908@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [121027 02:03]:
> 
> Rather than moving all the files from plat-omap/include/plat into plat-omap
> and then having all these totally disgusting relative includes, why don't
> you add to these makefiles:
> 
> ccflags += -I$(srctree)/arch/arm/plat-omap/include
> 
> and avoid all that include moving and all the include name fixup?

I'll take a look. Most of these headers should be local,
so it should not be too many files to move for plat-omap
to fix this.

Regards,

Tony
