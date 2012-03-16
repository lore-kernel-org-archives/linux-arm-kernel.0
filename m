From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Mar 2012 20:18:27 +0000
Subject: [PATCH 0/9 v5] ARM: kirkwood: fdt: convert kirkwood to fdt
In-Reply-To: <cover.1331868507.git.jason@lakedaemon.net>
References: <cover.1330625877.git.jason@lakedaemon.net>
 <cover.1331868507.git.jason@lakedaemon.net>
Message-ID: <201203162018.27957.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 March 2012, Jason Cooper wrote:
> 
> This series continues the process of converting all of the drivers initialized
> from kirkwood_init() to devicetree.
> 
> The first three patches are code cleanup from Andrew Lunn and myself.
> 
> The next three patches are cleanup and prep to facilitate adding new boards
> during the transition to devicetree.
> 
> The next patch moves the uarts into the bus for all kirkwood boards and leaves
> enabling them and specifying clock-frequency up to the board file.
> 
> The rest of the series is the initial conversion of rtc-mv to devicetree since
> it  doesn't use tclk or pinmux.  These should be safe to merge as they won't
> interfere with the clk/clkdev work Andrew Lunn is working on.
> 
>
> Please be aware that this is a complete reshuffle of the whole series and is
> based purely against arm-soc/next/boards.

Is this a pull request for v3.4 or not? I'm willing to take it and have put
it into next/dt2 for now so it makes it into linux-next. I'm not taking
a newer version for v3.4 any more, so if anyone has concerns over some of
your patches in the series, it all gets removed again and we will have to
postpone them until v3.5.

Note that it would have been better to base your series on top of just
the kirkwood/board branch rather than all of next/boards, but it's not
a big deal.

	Arnd
