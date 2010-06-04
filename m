From: darkstar6262@gmail.com (Cory Maccarrone)
Date: Fri, 4 Jun 2010 14:59:55 +0000 (UTC)
Subject: Heads up: Linus plans to kill ARM defconfigs
References: <20100603192459.GA9169@n2100.arm.linux.org.uk>
	<201006040337.10593.marek.vasut@gmail.com>
	<201006040350.36944.marek.vasut@gmail.com>
	<201006040353.35816.marek.vasut@gmail.com>
	<20100604060338.GH6499@atomide.com>
Message-ID: <loom.20100604T165709-423@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony <at> atomide.com> writes:

> 
> 
> Yeah, we should have just one omap1_defconfig. It should already
> mostly work already for 15xx + 16xx. To build in 7xx, the entry-macro.S
> needs to be done the same way as for mach-omap2.
> 
> Regards,
> 
> Tony
> 

All the new omap7xx boards I plan to submit in the future should be able to work
fine in a single defconfig.  That's how I build now with my development tree.
I'd be perfectly happy to see my htcherald_defconfig get wrapped into a more
generic omap1_defconfig.

They might even be generic enough that I won't need separate board files for
them -- I'll have to see when I get to that point.

- Cory
