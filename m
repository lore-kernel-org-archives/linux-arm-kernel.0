From: tony@atomide.com (Tony Lindgren)
Date: Fri, 23 Nov 2012 08:54:15 -0800
Subject: [PATCH 0/5] remaining omap multiplatform patches for v3.8
 merge window
In-Reply-To: <20121122202431.GS3332@n2100.arm.linux.org.uk>
References: <20121121174201.25576.61961.stgit@muffinssi.local>
 <20121122202431.GS3332@n2100.arm.linux.org.uk>
Message-ID: <20121123165414.GE5279@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [121122 12:26]:
> On Wed, Nov 21, 2012 at 09:42:19AM -0800, Tony Lindgren wrote:
> > There are few drivers still breaking because of their
> > use of plat/cpu.h and cpu_is_omap macros. The following
> > already have patches queued in linux next:
> > 
> > - drivers/staging/omapdrm/omap_drv.c
> > - drivers/staging/omapdrm/omap_dmm_tiler.h
> 
> Note that there's a bunch of OMAP drivers in staging which are trivially
> broken anyway; I've not been bothering to report their breakages which
> my build system is finding - I figure that if they're trivially broken
> with compile time errors which aren't config related, and no one's
> bothering to fixing them, then no one is even trying to build them -
> which means they're not being used.

Do you have a list of the broken drivers somewhere?
 
> And if they're not being used, it's pointless them being in mainline.

Yes makes sense to me.

Regards,

Tony
