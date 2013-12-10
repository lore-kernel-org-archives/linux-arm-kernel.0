From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 10 Dec 2013 19:44:48 +0000 (UTC)
Subject: [GIT PULL] make mach-omap2 boot with device tree only for
 v3.14
In-Reply-To: <201312102039.42933.arnd@arndb.de>
References: <pull-1386643347-596413> <20131210185902.GO13171@atomide.com>
 <20131210192726.GR13171@atomide.com> <201312102039.42933.arnd@arndb.de>
Message-ID: <alpine.DEB.2.02.1312101941090.32309@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 10 Dec 2013, Arnd Bergmann wrote:

> On Tuesday 10 December 2013, Tony Lindgren wrote:
> > board-ti8168evm.c
> > 
> > I doubt ti8168evm has even worked for a long time.. It's in pretty
> > sorry state unfortunately with missing clock support and missing
> > handle_irq entry in the board-ti8168evm.c.
> 
> Does that imply the entire ti81xx soc support is lacking, or just
> that board specifically? It seems to be the only board file that
> ever got merged.

We don't really support in mainline for 8148/8168 chips, so this is not 
much of a regression.  TI gave up trying to upstream it several years ago.

Aida Mynzhasova <aida.mynzhasova@skitlab.ru> has done some work on this 
recently, but I don't know what the current status is.  Maybe she can 
comment.


- Paul
