From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 25 Nov 2015 17:09:37 +0100
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <1448466557-435335-1-git-send-email-arnd@arndb.de>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
Message-ID: <20151125160937.GJ14338@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 04:49:12PM +0100, Arnd Bergmann wrote:
> I've posted these before and now gotten around to a rebase and
> want to include them in the arm-soc next/multiplatform branch for
> 4.5.
> 
> Originally the plan for these platforms was to convert all of
> them to DT and use only mach-mvebu. That has not happened,
> so I would do it this way instead so we can at least have
> them in a single kernel.
> 
> Let me know if there are any concerns or objections.

Maybe we should just remove mv78xx0? It has been at least two years
since we have heard of anybody using it, outside of Debians now
replaced build system. And its IRQ handling is broken apparently.

Russell, you are the last known user of mach-dove. What are your
plans? You keep saying you have given up trying to mainline your Cubox
patches. Have you really given up? Can we remove mach-dove?

Orion5x is still used, we occasionally get drive-by patches.

	 Andrew
