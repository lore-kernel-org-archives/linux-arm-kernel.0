From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Sep 2011 22:01:18 +0200
Subject: [GIT PULL] omap cleanup part1 for v3.2 merge window
In-Reply-To: <20110917014623.GC2937@atomide.com>
References: <20110917014623.GC2937@atomide.com>
Message-ID: <201109202201.18574.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 17 September 2011, Tony Lindgren wrote:
> Please pull the first part of omap cleanup from:
> 
> git://github.com/tmlind/linux.git cleanup
> 
> This series cleans up early_init functions and removes
> CHIP_IS macro usage. This makes it easier to have SoC
> specific init functions so adding support for new omap
> variants does not require patching all over the place.

Thanks, pulled.

Note that we are trying to get everyone to use the similar
prefixes for patch summaries, so it would be nice if you could
change 'OMAP: powerdomain:' to 'ARM: OMAP: powerdomain' or
'ARM: omap/powerdowmain:' in the future.

	Arnd
