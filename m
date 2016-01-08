From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 08 Jan 2016 17:49:20 +0100
Subject: [GIT PULL] urgent onenand file system corruption fix for n900
In-Reply-To: <20160108163250.GT12777@atomide.com>
References: <20160108163250.GT12777@atomide.com>
Message-ID: <9046751.uROfOxQcxi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 January 2016 08:32:50 Tony Lindgren wrote:
> Last minute urgent pull request to prevent file system corruption
> on Nokia N900.
> 
> Looks like we have a GPMC bus timing bug that has gone unnoticed
> because of bootloader configured registers until few days ago. We
> are not detecting the onenand clock rate properly unless we have
> CONFIG_OMAP_GPMC_DEBUG set and this causes onenand corruption
> that can be easily be reproduced.
> 
> There seems to be also an additional bug still lurking around for
> onenand corruption. But that is still being investigated and
> it does not seem to be GPMC timings related.
> 
> Meanwhile, it would be good to get this fix into v4.4 to prevent
> wrong timings from corrupting onenand.
> 

Pulled into fixes, thanks.

I'll try to get the fixes pull request out tonight, there are a
small number of other fixes.

	Arnd
