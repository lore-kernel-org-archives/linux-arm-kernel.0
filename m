From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Sep 2011 13:55:37 -0700
Subject: [GIT PULL] omap cleanup part1 for v3.2 merge window
In-Reply-To: <201109202201.18574.arnd@arndb.de>
References: <20110917014623.GC2937@atomide.com>
	<201109202201.18574.arnd@arndb.de>
Message-ID: <20110920205537.GI2937@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [110920 12:27]:
> On Saturday 17 September 2011, Tony Lindgren wrote:
> > Please pull the first part of omap cleanup from:
> > 
> > git://github.com/tmlind/linux.git cleanup
> > 
> > This series cleans up early_init functions and removes
> > CHIP_IS macro usage. This makes it easier to have SoC
> > specific init functions so adding support for new omap
> > variants does not require patching all over the place.
> 
> Thanks, pulled.
> 
> Note that we are trying to get everyone to use the similar
> prefixes for patch summaries, so it would be nice if you could
> change 'OMAP: powerdomain:' to 'ARM: OMAP: powerdomain' or
> 'ARM: omap/powerdowmain:' in the future.

Already did that for my patches.. Paul and Kevin, can you
please also start following that standard too?

Thanks,

Tony
