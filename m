From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Dec 2013 20:39:42 +0100
Subject: [GIT PULL] make mach-omap2 boot with device tree only for v3.14
In-Reply-To: <20131210192726.GR13171@atomide.com>
References: <pull-1386643347-596413> <20131210185902.GO13171@atomide.com>
 <20131210192726.GR13171@atomide.com>
Message-ID: <201312102039.42933.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 10 December 2013, Tony Lindgren wrote:
> board-ti8168evm.c
> 
> I doubt ti8168evm has even worked for a long time.. It's in pretty
> sorry state unfortunately with missing clock support and missing
> handle_irq entry in the board-ti8168evm.c.

Does that imply the entire ti81xx soc support is lacking, or just
that board specifically? It seems to be the only board file that
ever got merged.

	Arnd
